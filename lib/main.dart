import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/services/notification.dart';
import 'package:rayanSchool/views/homeScreen.dart';
import 'package:rayanSchool/views/loggedUser/Messages/MessagesScreen.dart';
import 'package:rayanSchool/views/parents/AttendanceScreen.dart';
import 'package:rayanSchool/views/parents/ReportsScreen.dart';
import 'package:rayanSchool/views/parents/recommendation_academic_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_list_screen.dart';
import 'package:rayanSchool/views/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rayanSchool/views/teacher/messages/MessagesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'I10n/AppLanguage.dart';
import 'I10n/app_localizations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var type = message.data["page"];
  prefs.setString("route", type);

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var type = message.data["page"];
      prefs.setString("route", type);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var type = message.data["page"];
      prefs.setString("route", type);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
        create: (_) => widget.appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            return MaterialApp(
              navigatorObservers: [observer],
              navigatorKey: navigatorKey,
              routes: {
                '/messages_student': (context) => MessagesScreen(),
                '/messages_teacher': (context) => MessagesTeacherScreen(),
                '/messages_parent': (context) => MessagesScreen(type: 2),
                '/attendance': (context) => AttendanceScreen(),
                '/report1': (context) => RecommendationAcademicListScreen(),
                '/report2': (context) => RecommendationsListScreen(),
                '/report': (context) => ReportScreen(),
              },
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              supportedLocales: [
                Locale("en", "US"),
                Locale("ar", ""),
              ],
              locale: model.appLocal,
              title: 'مدارس الريان',
              theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFFdcdbdb),
                primaryColor: mainColor,
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: 'DroidKufi',
                    ),
              ),
              home: SplashScreen(),
            );
          },
        ));
  }
}
