import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';

import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/loader.dart';

import '../../../globals/helpers.dart';
import '../../../web_view/web_view_screen.dart';

import '../../appData/new/news/NewsScreen.dart';
import '../../appData/school_policies/school_policy_screen.dart';
import '../../auth/login/login_screen.dart';
import 'controller/home_for_guest_controller.dart';

//this screen shown when the user is not logged in and want to see the home screen so this controller will check if there is any notification for the user and navigate to the appropriate screen based on the notification type and user type and also fetch the school social media link data to show it on the home screen

class HomeForGuestScreen extends StatelessWidget {
  final HomeForGuestController controller = Get.put(HomeForGuestController(), permanent: false);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // AppBar with logo and custom colors
      appBar: AppBar(

        iconTheme: new IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Obx(() {
          // Display a loading indicator while data is being fetched
          if (controller.isLoading.value) {
            return Loader();
          }
// Display the home screen content when data is loaded
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bcakGroundImg.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/logoname.png",
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.7),
                // Login Button
                _buildButton(
                  context,
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ?"Login":"تسجيل دخول",
                      () => Get.to(() => LoginScreen()),
                  icon: "assets/images/signInicons.png",
                ),
                // Admin Login Button for web view
                _buildButton(
                  context,
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ?"admin login":"تسجيل دخول مشرف",
                      () => Get.to(() => WebViewContainer(
                      "https://alrayyanprivateschools.com/supervisor")),
                  icon: "assets/images/signInicons.png",
                ),
                // Submit an application for admission Button for web view
                _buildButton(
                  context,
                    Get.find<StorageService>().activeLocale ==
                        SupportedLocales.english
                        ?"Submit an application for admission":"تقديم طلب التحاق",
                      () => Get.to(() => WebViewContainer(
                      "https://alrayyanprivateschools.com/application.php")),
                  icon: "assets/images/2icons.png",
                ),
                // School policies Button for school policies screen
                _buildButton(
                  context,
                    Get.find<StorageService>().activeLocale ==
                        SupportedLocales.english
                        ?"School policies":"السياسات المدرسية",
                      () => Get.to(() => SchoolPolicyScreen()),
                  icon: "assets/images/3icons.png",
                ),
                // News Button for news screen
                _buildButton(
                  context,
                    Get.find<StorageService>().activeLocale ==
                        SupportedLocales.english
                        ?"new news":"جديد الأخبار",
                      () => Get.to(() => NewsScreen()),
                  icon: "assets/images/newspaper.png",
                ),
                // Social Media Icons Row
                controller.isLoading.value?SizedBox(): Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                    InkWell( onTap: () => launchURL(controller.dataLink.value?.facebook??""), child: Container( decoration: BoxDecoration( color: Colors.white, shape: BoxShape.circle ), child: Padding( padding: const EdgeInsets.all(8.0), child: Image.asset( "assets/images/facebookIcon.png", height: MediaQuery.of(context).size.height*0.06 , width: MediaQuery.of(context).size.width*0.12, ), ), ), ),
                    InkWell( onTap: () => launchURL(controller.dataLink.value?.instagram??""), child: Container( decoration: BoxDecoration( color: Colors.white, shape: BoxShape.circle ), child: Padding( padding: const EdgeInsets.all(8.0), child: Image.asset( "assets/images/InstagramIcon.png", height: MediaQuery.of(context).size.height*0.06 , width: MediaQuery.of(context).size.width*0.12, ), ), ), ),
                    InkWell( onTap: () => launchURL(controller.dataLink.value?.twitter??""), child: Container( decoration: BoxDecoration( color: Colors.white, shape: BoxShape.circle ), child: Padding( padding: const EdgeInsets.all(8.0), child: Image.asset( "assets/images/twitter_icon.jpg", height: MediaQuery.of(context).size.height*0.06 , width: MediaQuery.of(context).size.width*0.12, ), ), ), ),
                    InkWell( onTap: () => launchURL(controller.dataLink.value?.youtube??""), child: Container( decoration: BoxDecoration( color: Colors.white, shape: BoxShape.circle ), child: Padding( padding: const EdgeInsets.all(8.0), child: Image.asset( "assets/images/youtubeIcon.png", height: MediaQuery.of(context).size.height*0.06 , width: MediaQuery.of(context).size.width*0.12, ), ), ), ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                  ], ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, VoidCallback onTap,
      {required String icon}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon,
              height: Get.height * 0.06,
              width: Get.width * 0.12),
          const SizedBox(width: 5),
          Container(
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(50.0),
            ),
            height: Get.height * 0.06,
            width: Get.width * 0.6,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
