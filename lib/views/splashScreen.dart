import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/views/homeScreen.dart';
import 'package:rayanSchool/views/parents/AttendanceScreen.dart';
import 'package:rayanSchool/views/parents/ReportsScreen.dart';
import 'package:rayanSchool/views/parents/recommendation_academic_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_list_screen.dart';
import 'package:rayanSchool/views/teacher/messages/MessagesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/helpers.dart';
import 'loggedUser/Messages/MessagesScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToHome();
  }

  goToHome() async {

      Future.delayed(
          Duration(seconds: 3),
              () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ))
      );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          Image.asset("assets/images/logo1.jpg"),
          SizedBox(height: 20),
          CircularProgressIndicator(
            backgroundColor: mainColor,
          ),
        ],
      )),
    );
  }
}
