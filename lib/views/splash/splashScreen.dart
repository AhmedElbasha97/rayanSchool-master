import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';

import '../../Utils/memory.dart';
import '../home/home_for_guests/home_for_guest_screen.dart';
import '../home/home_for_user/home_for_user_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  bool? userLogged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    print('[Splash] Checking login status...');
    final storage = Get.find<StorageService>();

    // ✅ Correct call — notice the parentheses
    userLogged = await storage.checkUserIsSignedIn;

    print('[Splash] User logged in? $userLogged');
    print('[Splash] Starting delay...');

    await Future.delayed(const Duration(seconds: 1));

    if (userLogged == true) {
      print('[Splash] Navigating → HomeLoggedInScreen');
      Get.offAll(() => HomeLoggedInScreen());
    } else {
      print('[Splash] Navigating → HomeForGuestScreen');
      Get.offAll(() => HomeForGuestScreen());
    }
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo1.png"),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              backgroundColor: mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
