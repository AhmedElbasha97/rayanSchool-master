
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
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  var type = message.data["page"];
  Get.find<StorageService>().saveNotificationRoute(type);

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  final api = ApiService();
  await api.init(); // Important for caching
  await PushNotificationService().setupInteractedMessage();
  FirebaseMessaging.instance.requestPermission();
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  }

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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var type = message.data["page"];
      Get.find<StorageService>().saveNotificationRoute(type);

    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var type = message.data["page"];
      Get.find<StorageService>().saveNotificationRoute(type);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
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
