
// ignore_for_file: unnecessary_import

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/services/notification.dart';

import 'package:rayanSchool/views/splash/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Utils/api_service.dart';
import 'Utils/localization_services.dart';
import 'Utils/memory.dart';
import 'Utils/transelation/app_transelation.dart';
import 'firebase_options.dart';
import 'I10n/AppLanguage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
// Main entry point of the application
// Initializes Firebase, sets up localization, and configures push notifications
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  var type = message.data["page"];
  Get.find<StorageService>().saveNotificationRoute(type);

}
void main() async {
  // Ensure Flutter bindings are initialized before any asynchronous operations
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize StorageService and LocalizationService using GetX for dependency injection
  await Get.putAsync(() => StorageService.init(), permanent: true);
  Get.put(LocalizationService.init(), permanent: true);

// ✅ إعداد ألوان الـ StatusBar و NavigationBar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // statusBarColor: kDarkGreenColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    // systemNavigationBarColor: kDarkGreenColor,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  // Initialize the API service and set up push notifications
  final api = ApiService();
  await api.init(); // Important for caching
  // Set up push notifications and request permissions
  await PushNotificationService().setupInteractedMessage();
  // Request permission for push notifications
  FirebaseMessaging.instance.requestPermission();
  // Handle the case where the app is opened from a terminated state via a notification
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  // If the app was opened from a notification, set up the background message handler
  if (initialMessage != null) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  }
// Create an instance of AppLanguage to manage localization and fetch the current locale
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage));

}

class MyApp extends StatefulWidget {
  final AppLanguage? appLanguage;
  MyApp({ this.appLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    // Listen for messages when the app is in the foreground and save the notification route
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var type = message.data["page"];
      Get.find<StorageService>().saveNotificationRoute(type);

    });
// Listen for messages when the app is opened from a notification and save the notification route
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var type = message.data["page"];
      Get.find<StorageService>().saveNotificationRoute(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lock the app orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      // Set up the main application with localization, theming, and navigation
      navigatorObservers: [observer],
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.find<LocalizationService>().activeLocale,
      supportedLocales: SupportedLocales.all,
      fallbackLocale: SupportedLocales.english,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.green,
        fontFamily: 'DroidKufi',
        // Configure the AppBar theme with a custom background color and system overlay styles for status bar and navigation bar
        appBarTheme: AppBarTheme(
          backgroundColor: mainColor,
          iconTheme: const IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: mainColor,
            systemNavigationBarColor: mainColor,
            systemNavigationBarDividerColor: mainColor,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarContrastEnforced: true,
            systemStatusBarContrastEnforced: true,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      home:  SplashScreen(),
    );
  }
}
