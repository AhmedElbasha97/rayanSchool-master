// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/albums/AlbumsScreen.dart';
import 'package:rayanSchool/views/appData/new/news/NewsScreen.dart';
import 'package:rayanSchool/views/appData/privacy_policy/privacyPolicyScreen.dart';
import 'package:rayanSchool/views/appData/subject/subjects/subjectsScreen.dart';
import 'package:rayanSchool/views/auth/login/login_screen.dart';
import 'package:rayanSchool/views/accounts/student_account/myAccount.dart';
import 'package:rayanSchool/views/accounts/teacher_account/myAccountTeacher.dart';
import 'package:rayanSchool/views/accounts/parent_account/myAccoutParent.dart';
import 'package:rayanSchool/views/home/home_for_guests/home_for_guest_screen.dart';
import 'package:rayanSchool/views/splash/splashScreen.dart';
import 'package:share_plus/share_plus.dart';
import '../Utils/memory.dart';
import '../Utils/translation_key.dart';
import '../models/school_social_media_link_model.dart';
import '../services/appInfoService.dart';
import '../views/appData/about_app/about_app_screen.dart';
import '../views/home/home_for_user/home_for_user_screen.dart';
import '../web_view/web_view_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
   bool? userLogged;
   bool? isStudent;
   bool? isTeacher;
   bool isLoading=true;
   SchoolSocialMediaLinkModel? dataLink ;

   @override
  void initState() {
    super.initState();
    checkData();
    getSocialLinkData();
  }

  checkData() async {
    userLogged = Get.find<StorageService>().checkUserIsSignedIn ;
    isStudent = Get.find<StorageService>().getUserType == "STUDENT" ? true : false;
    isTeacher = Get.find<StorageService>().getUserType == "TEACHER" ? true : false;
    setState(() {});
  }
getSocialLinkData() async {
  dataLink = await AppInfoService().getSchoolSocialMediaLink();
isLoading =false;
setState(() {

});
}
   void shareUrl(String text, BuildContext context){
     try{
       Size size = MediaQuery.of(context).size;
       double screenWidth = size.width;
       double screenHeight = size.height;
       Share.share(text,
           sharePositionOrigin: Rect.fromLTWH(0, 0, screenWidth,
               screenHeight));
     } catch (e) {
     print(e);
     }
   }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/logoname.png"),
          ),
          SizedBox(height: 50),
          ListTile(
            title: Text(
              homePage.tr,
              style: TextStyle(
                  color: mainColor,     fontFamily: 'DroidKufi',fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.home),
            onTap: () {
              popPage(context);

              if(userLogged??false) {
                Get.to(() =>   HomeLoggedInScreen() );
              }else{
                Get.to(() =>   HomeForGuestScreen() );

              }
            },
          ),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
            joinRequest.tr,
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.person_add_rounded),
            onTap: () {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>WebViewContainer("https://alrayyanprivateschools.com/application.php"),
              ));
            },
          ),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          userLogged??false
              ? ListTile(
                  title: Text(
                    myAccount.tr,
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,    fontFamily: 'DroidKufi',
                        fontSize: 14),
                  ),
                  leading: Icon(Icons.person),
                  onTap: () {
                    popPage(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => isStudent??false
                          ? MyAccount()
                          : isTeacher??false
                              ? MyAccountTeacher()
                              : MyAccountParent(),
                    ));
                  },
                )
              : ListTile(
                  title: Text(
                    login.tr,
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,    fontFamily: 'DroidKufi',
                        fontSize: 14),
                  ),
                  leading: Icon(Icons.login),
                  onTap: () {
                    popPage(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                ),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          // ListTile(
          //   title: Text(
          //     "${AppLocalizations.of(context).translate('changeLang')}",
          //     style: TextStyle(
          //         color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
          //   ),
          //   leading: Icon(Icons.translate),
          //   onTap: () => showCupertinoModalPopup(
          //       context: context,
          //       builder: (BuildContext context) => changeLangPopUp(context)),
          // ),
          // Divider(
          //   height: 1,
          //   thickness: 2,
          //   endIndent: 30,
          //   indent: 30,
          // ),
          userLogged??false
              ? Column(
                children: [
                  ListTile(
                              title: Text(
                  complains.tr,
                  style: TextStyle(
                      color: mainColor,     fontFamily: 'DroidKufi',fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              leading: Icon(Icons.photo),
                              onTap: () async {
                  popPage(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>WebViewContainer("https://alrayyanprivateschools.com/complaints.php"),
                  ));
                              },
                            ),
                  Divider(
                    height: 1,
                    thickness: 2,
                    endIndent: 30,
                    indent: 30,
                  ),
                ],
              ):SizedBox(),

          ListTile(
            title: Text(
              photosAlbum.tr,
              style: TextStyle(
                  color: mainColor,     fontFamily: 'DroidKufi',fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.photo),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AlbumsScreen(),
              ));
            },
          ),

          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
             videosAlbum.tr,
              style: TextStyle(
                  color: mainColor,    fontFamily: 'DroidKufi', fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.video_library),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AlbumsScreen(
                  isImg: false,
                ),
              ));
            },
          ),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              books.tr,
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.auto_stories),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SubjectsScreen(),
              ));
            },
          ),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
         newNews.tr,
              style: TextStyle(
                  color: mainColor,      fontFamily: 'DroidKufi',fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.public),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewsScreen(),
              ));
            },
          ),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),


          ListTile(
              title: Text(
                aboutTheApp.tr,
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DroidKufi',
                    fontSize: 14),
              ),
              leading: Icon(Icons.description),
              onTap: () {
                popPage(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutAppScreen(),
                ));
              }),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
              title: Text(
                privacyPolicy.tr,
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DroidKufi',
                    fontSize: 14),
              ),
              leading: Icon(Icons.description),
              onTap: () {
                popPage(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PrivacyPolicyScreen(),
                ));
              }),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          ListTile(
            title: Text(
              share.tr,
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold,     fontFamily: 'DroidKufi',fontSize: 14),
            ),
            leading: Icon(Icons.share),
            onTap: () {
              String link =
                  "https://play.google.com/store/apps/details?id=com.syncQatar.rayanSchool";
              if (Platform.isIOS) {
                link =
                    "https://apps.apple.com/us/app/%D9%85%D8%AF%D8%B1%D8%B3%D8%A9-%D8%A7%D9%84%D8%B1%D9%8A%D8%A7%D9%86/id1563613632";
              }
              shareUrl(link,context);
            },
          ),
          Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ),
          userLogged??false
              ? ListTile(
                  title: Text(
                    signOut.tr,
                    style: TextStyle(
                        color: mainColor,
                        fontFamily: 'DroidKufi',
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () async {
                    await Get.find<StorageService>().loggingOut();

                    Get.offAll(() => SplashScreen(),

                    transition: Transition.rightToLeft,);
                  },
                )
              : Container(),

          isLoading?SizedBox():Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
              InkWell(
                 onTap: () => launchURL("${dataLink?.facebook??""}"),
                child: Image.asset(
                  "assets/images/facebook.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                 onTap: () => launchURL("${dataLink?.instagram??""}"),
                child: Image.asset(
                  "assets/images/instagram.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                // onTap: () => launchURL("$twitterUrl"),
                child: Image.asset(
                  "assets/images/twitter.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                 onTap: () => launchURL("https://wa.me/${dataLink?.whatsapp??""}"),
                child: Image.asset(
                  "assets/images/whatsapp.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                 onTap: () => launchURL("${dataLink?.youtube??""}"),
                child: Image.asset(
                  "assets/images/youtube.png",
                  scale: 10,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              policy1.tr,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(policy2.tr,
                    style: TextStyle(fontSize: 16)),
                InkWell(
                  onTap: () => launchURL("https://syncqatar.com"),
                  child: Text(
                    "سينك",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
