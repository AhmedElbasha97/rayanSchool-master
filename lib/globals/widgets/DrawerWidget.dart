import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/albums/AlbumsScreen.dart';
import 'package:rayanSchool/views/appData/NewsScreen.dart';
import 'package:rayanSchool/views/appData/aboutApp.dart';
import 'package:rayanSchool/views/appData/contact_us_screen.dart';
import 'package:rayanSchool/views/appData/privacyPolicyScreen.dart';
import 'package:rayanSchool/views/appData/subjectsScreen.dart';
import 'package:rayanSchool/views/auth/login.dart';
import 'package:rayanSchool/views/myAccount.dart';
import 'package:rayanSchool/views/myAccountTeacher.dart';
import 'package:rayanSchool/views/myAccoutParent.dart';
import 'package:rayanSchool/views/other/joinRequest.dart';
import 'package:rayanSchool/views/splashScreen.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../views/auth/change_password_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
   bool? userLogged;
   bool? isStudent;
   bool? isTeacher;

  @override
  void initState() {
    super.initState();
    checkData();
  }

  checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userLogged = prefs.getString("id") == null ? false : true;
    isStudent = prefs.getString("type") == "STUDENT" ? true : false;
    isTeacher = prefs.getString("type") == "TEACHER" ? true : false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/logoname.jpg"),
          ),
          SizedBox(height: 50),
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)?.translate('homePage')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.home),
            onTap: () {
              popPage(context);
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
              "${AppLocalizations.of(context)?.translate('joinRequest')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.person_add_rounded),
            onTap: () {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => JoinRequest(),
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
                    "${AppLocalizations.of(context)?.translate('myAccount')}",
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
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
                    "${AppLocalizations.of(context)?.translate('login')}",
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
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
          ListTile(
            title: Text(
              "${AppLocalizations.of(context)?.translate('complains')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.photo),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContactUsScreen(),
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
              "${AppLocalizations.of(context)?.translate('PhotosAlbum')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
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
              "${AppLocalizations.of(context)?.translate('videosAlbum')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
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
              "${AppLocalizations.of(context)?.translate('books')}",
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
              "${AppLocalizations.of(context)?.translate('newNews')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
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
          userLogged??false?ListTile(
            title: Text(
              "${AppLocalizations.of(context)?.translate('changePass')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.password_rounded),
            onTap: () async {
              popPage(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangePasswordScreen(),
              ));
            },
          ):Container(),
          userLogged??false?Divider(
            height: 1,
            thickness: 2,
            endIndent: 30,
            indent: 30,
          ):Container(),
          ListTile(
              title: Text(
                "${AppLocalizations.of(context)?.translate('aboutTheApp')}",
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
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
                "${AppLocalizations.of(context)?.translate('privacyPolicy')}",
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
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
              "${AppLocalizations.of(context)?.translate('share')}",
              style: TextStyle(
                  color: mainColor, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            leading: Icon(Icons.share),
            onTap: () {
              String link =
                  "https://play.google.com/store/apps/details?id=com.syncQatar.rayanSchool";
              if (Platform.isIOS) {
                link =
                    "https://apps.apple.com/us/app/%D9%85%D8%AF%D8%B1%D8%B3%D8%A9-%D8%A7%D9%84%D8%B1%D9%8A%D8%A7%D9%86/id1563613632";
              }
              Share.share( '$link', subject: ' App Called Rayan schools');
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
                    "${AppLocalizations.of(context)?.translate('signOut')}",
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    popPage(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ));
                  },
                )
              : Container(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
              InkWell(
                // onTap: () => launchURL("$facebookUrl"),
                child: Image.asset(
                  "assets/images/facebook.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                // onTap: () => launchURL("$instagramUrl"),
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
                // onTap: () => launchURL("https://wa.me/$whatsappUrl"),
                child: Image.asset(
                  "assets/images/whatsapp.png",
                  scale: 1.5,
                ),
              ),
              InkWell(
                // onTap: () => launchURL("$youtubeUrl"),
                child: Image.asset(
                  "assets/images/snapchat.png",
                  scale: 1.5,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "${AppLocalizations.of(context)?.translate('policy1')}",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("${AppLocalizations.of(context)?.translate('policy2')}",
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
