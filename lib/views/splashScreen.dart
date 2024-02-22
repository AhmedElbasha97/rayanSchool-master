import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/views/homeScreen.dart';

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

  goToHome() {
    Future.delayed(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )));
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
