
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
    print(NotificationCounterEndPoint+"?user_id: $userId&type: $userType");
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
    String? userId = prefs.getString("id");
    String? userType = prefs.getString("type") ;
    Map<String, dynamic>? body = {
      "user_id": "$userId",
      "type": "$userType",
    };
    response = await Dio().get("$NotificationEndPoint?user_id=$userId&type=$userType",);
    print('$NotificationEndPoint?user_id: $userId&type: $userType');
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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> setupInteractedMessage() async {
    // 1. تهيئة Firebase
    await Firebase.initializeApp();

    // 2. طلب الإذن للإشعارات
    final settings = await FirebaseMessaging.instance.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    // 3. تعامل مع الحالة اللي التطبيق كان مغلق فيها وفتح من إشعار
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _handleMessage(initialMessage);

    }

    // 4. عندما يُفتح التطبيق من الخلفية بسبب إشعار
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await _handleMessage(message);

    });

    // 5. إعداد الإشعارات في iOS
    await enableIOSNotifications();

    // 6. تفعيل مستمعي الإشعارات
    await registerNotificationListeners();
  }

  Future<void> registerNotificationListeners() async {
    // إنشاء القناة (Android)
    AndroidNotificationChannel channel = androidNotificationChannel();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // إعدادات التهيئة
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    final initSettings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);

    // تهيئة الإشعارات المحلية
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (message) async {
        await notificationSelectingAction();
      },
    );

    // استقبال الإشعارات في الـ foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message == null) return;

      await _handleMessage(message);

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = notification?.android;

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
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    final type = message.data["page"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("route", type);
  }

  static Future<void> notificationSelectingAction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userType = prefs.getString("type");
    String? screenType = prefs.getString("route");

    print('userType: ${userType ?? ""}');
    print('screenType: ${screenType ?? ""}');

    if (screenType == null) return;

    final Map<String, String> messageRoutes = {
      "STUDENT": "/messages_student",
      "TEACHER": "/messages_teacher",
      "PARENTS": "/messages_parent",
    };
    final Map<String, String> homeworkRoutes = {
      "STUDENT": "/homework_student",
      "TEACHER": "/homework_teacher",
    };

    switch (screenType) {
      case "msg":
        final route = messageRoutes[userType];
        if (route != null) {
          _navigateTo(route);
        }
        break;

      case "absence":
        _navigateTo('/attendance');
        break;

      case "report1":
        _navigateTo('/report1');
        break;

      case "report":
        _navigateTo('/report');
        break;

      case "report2":
        _navigateTo('/report2');
        break;
        case "penalty":
        _navigateTo('/penalties');
        break;
        case "homework":
          final route = homeworkRoutes[userType];
          if (route != null) {
            _navigateTo(route);
          }
          break;

      default:
        print("Unrecognized notification type: $screenType");
        break;
    }

    prefs.remove("route");
  }

  static void _navigateTo(String route) {
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState?.pushNamed(route);
    });
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // name
        importance: Importance.max,
      );
}