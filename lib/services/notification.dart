
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals/CommonSetting.dart';
import '../globals/helpers.dart';
import '../main.dart';
import '../models/notification_counter_model.dart';
import '../models/notification_model.dart';

class NotificationServices{
  String NotificationEndPoint = "${baseUrl}notification2.php";
  String NotificationCounterEndPoint = "${baseUrl}notification_count.php";
  Future<NotificationCounterModel?> counterNotification() async {
    Response response;
    NotificationCounterModel? result ;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =await prefs.getString("id") ?? "";
    String userType =await prefs.getString("type") ?? "";
    Map<String, dynamic>? body = {
      "user_id": "$userId",
      "type": "$userType",
    };
    response = await Dio().get('$NotificationCounterEndPoint',queryParameters:body);
    print(NotificationCounterEndPoint);
    print("hiiiiiiiiiiiiii$userId");
    print("bggkk$userType");
    var data = response.data;
    print(response.data);
    if(response.data != null) {
      result = NotificationCounterModel.fromJson(response.data);
      return result;
    }else{
      return null;
    }

  }
  Future<List<NotificationModel>?> listAllNotification() async {
    Response response;
    List<NotificationModel> result = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId =await prefs.getString("id") ?? "";
    String userType =await prefs.getString("type") ?? "";
    Map<String, dynamic>? body = {
      "user_id": "$userId",
      "type": "$userType",
    };
    response = await Dio().get('$NotificationEndPoint',queryParameters:body);
    print(NotificationEndPoint);
    print("hiiiiiiiiiiiiii$userId");
    print("bggkk$userType");
    var data = response.data;
    print(response.data);
    if(response.data != null) {
      for (var notification in response.data) {
        result.add(NotificationModel.fromJson(notification));
      }
      return result;
    }else{
      return null;
    }

  }
}

class PushNotificationService {


  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var type= message.data["page"];
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("route", type);
      notificationSelectingAction(message);
    });
    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSSettings =  const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initSetttings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,onDidReceiveNotificationResponse:  (message) async {
      notificationSelectingAction(message);
    }
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      var type= message.data["page"];
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("route", type);
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,

              icon: android.smallIcon,
              playSound: true,
            ),
          ),
        );
      }
    });
  }
  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  static Future<void> notificationSelectingAction( message,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userType = prefs.getString("type");

   String? screenType =  prefs.getString("route");
    switch (screenType) {
      case "msg":
        if (userType == "student") {
          navigatorKey.currentState?.pushNamed('/messages_student');
        } else if (userType == "teacher") {
          navigatorKey.currentState?.pushNamed('/messages_teacher');
        } else if (userType == "parent") {
          navigatorKey.currentState?.pushNamed('/messages_parent');
        }
        break;

      case "absence":
        prefs.remove("route");
        navigatorKey.currentState?.pushNamed('/attendance');
        break;

      case "report1":
        prefs.remove("route");
        navigatorKey.currentState?.pushNamed('/report1');
        break;
        case "report":
        prefs.remove("route");
        navigatorKey.currentState?.pushNamed('/report');
        break;

      case "report2":
        prefs.remove("route");
        navigatorKey.currentState?.pushNamed('/report2');
        break;

      default:
        print("Unrecognized notification type: $screenType");
        break;
    }
  }


  androidNotificationChannel() => const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title

    importance: Importance.max,
  );
}