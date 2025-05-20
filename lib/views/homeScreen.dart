import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/globals/widgets/DrawerWidget.dart';
import 'package:rayanSchool/globals/widgets/HomeCard.dart';
import 'package:rayanSchool/models/AppInfo/photoAlbum.dart';
import 'package:rayanSchool/models/AppInfo/sliderPhotos.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';
import 'package:rayanSchool/services/albums.dart';
import 'package:rayanSchool/services/appInfoService.dart';
import 'package:rayanSchool/views/Notification/notification_list.dart';
import 'package:rayanSchool/views/parents/AttendanceScreen.dart';
import 'package:rayanSchool/views/parents/ReportsScreen.dart';
import 'package:rayanSchool/views/parents/penalties_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_academic_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_list_screen.dart';
import 'package:rayanSchool/views/school_policies_screen.dart';
import 'package:rayanSchool/views/teacher/homework_teacher_list_screen.dart';
import 'package:rayanSchool/views/teacher/messages/MessagesScreen.dart';
import 'package:rayanSchool/views/teacher/messages/receidvedMessageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/widgets/notification_icon.dart';
import '../models/school_social_media_link_model.dart';
import '../models/school_social_media_link_model.dart';
import '../models/school_social_media_link_model.dart';
import '../web_view/web_view_screen.dart' show WebViewContainer;
import 'appData/NewsScreen.dart';
import 'appData/activity_screen.dart';
import 'appData/contact_us_screen.dart';
import 'appData/schoolWord.dart';
import 'appData/school_policy_screen.dart';
import 'auth/login.dart';
import 'loggedUser/Messages/MessagesScreen.dart';
import 'loggedUser/homeWork.dart';
import 'other/joinRequest.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  List<SliderData> sliderData = [];
  List<PhotoAlbum>? list = [];
  List<Videos>? list2 = [];
  bool userLogged = true;
  SchoolSocialMediaLinkModel? dataLink ;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    decideIfThereIsNotificationDetectOrNotAndItIsBehavior();
    getHomeData();
  }
decideIfThereIsNotificationDetectOrNotAndItIsBehavior() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var type= prefs.getString("route");
  print(prefs.containsKey("route"));
  print(type);
  if(prefs.containsKey("route")) {
    switch (type) {
      case "msg":
        prefs.remove("route");
        {
          if (prefs.getString("type") == "STUDENT") {
            pushPage(
                context,
                MessagesScreen(
                ));
          } else if (prefs.getString("type") == "TEACHER") {
            pushPage(
                context,
                ReceivedMessageScreen(
                ));
          } else if (prefs.getString("type") == "PARENTS") {
            pushPage(
                context,
                MessagesScreen(
                  type: 2,
                ));
          }
        }
        break;
      case "absence":
        {
          prefs.remove("route");
          pushPage(context, AttendanceScreen());
        }
        break;
      case "report1":
        {
          prefs.remove("route");

          pushPage(
              context,
              RecommendationAcademicListScreen(
              ));
        }
        break;
      case "report":
        {
          prefs.remove("route");

          pushPage(
              context,
              ReportScreen(
              ));
        }
        break;
      case "report2 ":
        {
          prefs.remove("route");
          pushPage(
              context,
              RecommendationsListScreen(
              ));
        }
        break;
      case "penalty":
        {
          pushPage(
              context,
              PenaltiesListScreen(
              ));
        }
        break;
      case "homework":
        {

          if (prefs.getString("type") == "STUDENT") {
            pushPage(
                context,
                HomeWorkScreen(
                ));
          } else if (prefs.getString("type") == "TEACHER") {
            pushPage(
                context,
                HomeworkTeacherListScreen(
                ));
          }
        }
        break;
    }
  }
}
  getHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userLogged = prefs.getString("id") == null ? false : true;

    if(!userLogged){
      dataLink = await AppInfoService().getSchoolSocialMediaLink();
    }else{
      sliderData = await AppInfoService().getSliderPhotos();
    }
    await getAlbumsData();
    loading = false;
    setState(() {});
  }

  getAlbumsData() async {
    list = await AlbumsService().getphotoAlbums();
    list2 = await AlbumsService().getVideoAlbums();
  }

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          userLogged?InkWell(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotificationsListScreen()),
              );
    },

            child: Ink(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: NotificationIcon(),
              ),
            ),
          ):Container(),
        ],
        iconTheme: new IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body:userLogged?loading
          ?Container(
          width: MediaQuery.of(context).size.width ,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bcakGroundImg.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
            child: Center(
                    child: CircularProgressIndicator(),
                  ),
          )
          :Container(
        width: MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bcakGroundImg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
            child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    shrinkWrap: true,
                    children: [
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              options: CarouselOptions(height: 150.0, autoPlay: true),
              items: sliderData.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://www.alrayyanprivateschools.com/${i.img}"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)?.translate('aboutTheSchool')??"",
                style: appText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  HomeCard(
                    width: MediaQuery.of(context).size.width*0.45,

                    onTap: () {
                      pushPage(context, SchoolWord());
                    },
                    title:
                    "${AppLocalizations.of(context)?.translate('schoolWord')}",
                    imageLink: "assets/images/school.png",
                  ),

                  HomeCard(
                    width: MediaQuery.of(context).size.width*0.45,

                    onTap: () {
                      pushPage(
                          context,
                          SchoolWord(
                            isAbout: true,
                          ));
                    },
                    title:
                    "${AppLocalizations.of(context)?.translate('schoolVision')}",
                    imageLink: "assets/images/vision.png",
                  ),
                  HomeCard(
                    width: MediaQuery.of(context).size.width*0.45,

                    onTap: () {
                      pushPage(
                          context,
                          SchoolPoliciesScreen(

                          ));
                    },
                    title:
                    "${Localizations.localeOf(context).languageCode == "en"
                        ?"School Policies":"السياسات المدرسية"}",
                    imageLink: "assets/images/School Policies.png",
                  ),
                ],
              ),
            ),
            //====================================================================
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)?.translate('news')??"",
                style: appText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  HomeCard(
                    width: MediaQuery.of(context).size.width*0.45,

                    onTap: () {
                      pushPage(context, ActivityScreen());
                    },
                    title:
                    "${AppLocalizations.of(context)?.translate('activity')}",
                    imageLink: "assets/images/activities.png",
                  ),
                  HomeCard(
                    width: MediaQuery.of(context).size.width*0.45,
                    onTap: () {
                      pushPage(context, SchoolWord());
                    },
                    title:
                    "${AppLocalizations.of(context)?.translate('newNews')}",
                    imageLink: "assets/images/newNews.png",
                  ),
                ],
              ),
            ),
            // ====================================================================
            SizedBox(
              height: 20,
            ),
                      // ====================================================================

                      Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)?.translate('PhotosAlbum')??"",
                style: appText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
                      list?.isEmpty??true?
                      Container(
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: 20,),
                            Text(Localizations.localeOf(context).languageCode == "en"
                                ?"no Photos available":"لا يوجد ألبوم الصور متوفرة الآن",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20

                              ),),
                          ],
                        ),
                      ):CarouselSlider(
              options: CarouselOptions(height: 150.0, autoPlay: true),
              items: list?.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${i.img}"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                    );
                  },
                );
              }).toList(),
            ),
            //====================================================================
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)?.translate('videosAlbum')??"",
                style: appText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
                      list2?.isEmpty??true?
                      Container(
                        height: MediaQuery.of(context).size.height*0.35,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: 20,),
                            Text(Localizations.localeOf(context).languageCode == "en"
                                ?"no Videos available":"لا يوجد ألبوم الفيديو متوفرة الآن",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20

                              ),),
                          ],
                        ),
                      ):CarouselSlider(
              options: CarouselOptions(height: 150.0, autoPlay: true),
              items: list2?.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${i.img}"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                    );
                  },
                );
              }).toList(),
            ),
            //====================================================================
                    ],
                  ),
          ):
      Container(
        width: MediaQuery.of(context).size.width ,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bcakGroundImg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/logoname.png",
              height: MediaQuery.of(context).size.height*0.1 ,
              width: MediaQuery.of(context).size.width*0.7 ,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/signInicons.png",
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.6 ,
                    child: Center(
                      child: Text(
                        Localizations.localeOf(context).languageCode == "en"
                            ?"Login":"تسجيل دخول",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebViewContainer("https://alrayyanprivateschools.com/supervisor"),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/signInicons.png",
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.6 ,
                    child: Center(
                      child: Text(
                        Localizations.localeOf(context).languageCode == "en"
                            ?"admin login":"تسجيل دخول مشرف",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>WebViewContainer("https://alrayyanprivateschools.com/application.php"),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                  "assets/images/2icons.png",
                  height: MediaQuery.of(context).size.height*0.06 ,
                  width: MediaQuery.of(context).size.width*0.12,
                ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.6 ,
                    child: Center(
                      child: Text(
                        Localizations.localeOf(context).languageCode == "en"
                            ?"Submit an application for admission":"تقديم طلب التحاق",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),


                ],
              ),
            ),
            InkWell(
              onTap: (){
                pushPage(
                    context,
                    SchoolPolicyScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Image.asset(
                    "assets/images/3icons.png",
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.6 ,
                    child: Center(
                      child: Text(
                        Localizations.localeOf(context).languageCode == "en"
                            ?"School policies":"السياسات المدرسية",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/newspaper.png",
                  height: MediaQuery.of(context).size.height*0.06 ,
                  width: MediaQuery.of(context).size.width*0.12,
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewsScreen(),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    height: MediaQuery.of(context).size.height*0.06 ,
                    width: MediaQuery.of(context).size.width*0.6 ,
                    child: Center(
                      child: Text(
                        Localizations.localeOf(context).languageCode == "en"
                            ?"new news":"جديد الأخبار",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ),

              ],
            ),
           loading?SizedBox(): Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
                InkWell(
                   onTap: () => launchURL(dataLink?.facebook??""),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/facebookIcon.png",
                        height: MediaQuery.of(context).size.height*0.06 ,
                        width: MediaQuery.of(context).size.width*0.12,
                      ),
                    ),
                  ),
                ),
                InkWell(
                   onTap: () => launchURL(dataLink?.instagram??""),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/InstagramIcon.png",
                        height: MediaQuery.of(context).size.height*0.06 ,
                        width: MediaQuery.of(context).size.width*0.12,
                      ),
                    ),
                  ),
                ),
                InkWell(
                   onTap: () => launchURL(dataLink?.twitter??""),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/twitter_icon.jpg",

                        height: MediaQuery.of(context).size.height*0.06 ,
                        width: MediaQuery.of(context).size.width*0.12,
                      ),
                    ),
                  ),
                ),
                InkWell(
                   onTap: () => launchURL(dataLink?.youtube??""),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/youtubeIcon.png",
                        height: MediaQuery.of(context).size.height*0.06 ,
                        width: MediaQuery.of(context).size.width*0.12,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 1)),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
