
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/api_service.dart';
import '../Utils/memory.dart';
import '../Utils/services.dart';
import '../models/notification_counter_model.dart';
import '../models/notification_model.dart';

import '../views/loggedUser/homework/homeworks/homeworks_screen.dart';
import '../views/parents/attendance/AttendanceScreen.dart';

import '../views/parents/messages/sented_mesages/sented_messages_screen.dart';
import '../views/teacher/homework/homeworks_list/homework_teacher_list_screen.dart';
import '../web_view/web_view_screen.dart';


class NotificationServices{
  final ApiService api = ApiService();

  Future<NotificationCounterModel?> counterNotification() async {
    try {
      Map<String, dynamic>? body = {
        "user_id": Get
            .find<StorageService>()
            .getId,
        "type": Get
            .find<StorageService>()
            .getUserType,
      };
      final data = await api.request(Services.NotificationCounterEndPoint,"GET",queryParameters: body,);

      if ( data.isNotEmpty) {
        return NotificationCounterModel.fromJson(data);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ counterNotification error: $e");
      return null;
    }
  }
  Future<List<NotificationModel>?> listAllNotification() async {
    try {
      Map<String, dynamic>? body = {
        "user_id": Get
            .find<StorageService>()
            .getId,
        "type": Get
            .find<StorageService>()
            .getUserType,
      };
      final data = await api.request(Services.NotificationEndPoint,"GET",queryParameters: body,);

      if (data is List) {
        return data
            .map((e) => NotificationModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ listAllNotification error: $e");
      return [];
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
    String? userType =  Get.find<StorageService>().getUserType;
    String? screenType =  Get.find<StorageService>().getNotificationRoute;

    print('userType: ${userType}');
    print('screenType: ${screenType}');



    switch (screenType) {
      case "msg":
        Get.find<StorageService>().removeNotification();
        {
           if ( Get.find<StorageService>().getUserType == "PARENTS") {
            Get.to(SentedMessagesScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
          }
        }
        break;
      case "absence":
        {
          Get.find<StorageService>().removeNotification();
          Get.to(()=>AttendanceScreen(),transition: Transition.rightToLeft,preventDuplicates: true,duration: const Duration(seconds: 1));

        }
        break;
      case "report1":
        {
          Get.find<StorageService>().removeNotification();
          Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
              .find<StorageService>()
              .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
        }
        break;
      case "report":
        {
          Get.find<StorageService>().removeNotification();
          Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
              .find<StorageService>()
              .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
        }
        break;
      case "report2 ":
        {
          Get.find<StorageService>().removeNotification();
          Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
              .find<StorageService>()
              .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
        }
        break;
      case "penalty":
        {
          Get.find<StorageService>().removeNotification();
          Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
              .find<StorageService>()
              .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
        }
        break;
      case "homework":
        {
          Get.find<StorageService>().removeNotification();
          if ( Get.find<StorageService>().getUserType == "STUDENT") {
            Get.to(()=>HomeWorkScreen(),transition: Transition.rightToLeft,preventDuplicates: true,duration: const Duration(seconds: 1));
          } else if ( Get.find<StorageService>().getUserType == "TEACHER") {
            Get.to(()=>HomeworkTeacherListScreen(),transition: Transition.rightToLeft,preventDuplicates: true,duration: const Duration(seconds: 1));
          }
        }
        break;
    }
  }



  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // name
        importance: Importance.max,
      );
}