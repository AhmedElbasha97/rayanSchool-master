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
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/widgets/notification_icon.dart';
import '../models/school_social_media_link_model.dart';
import '../models/school_social_media_link_model.dart';
import '../models/school_social_media_link_model.dart';
import 'appData/NewsScreen.dart';
import 'appData/activity_screen.dart';
import 'appData/contact_us_screen.dart';
import 'appData/schoolWord.dart';
import 'auth/login.dart';
import 'other/joinRequest.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SliderData> sliderData = [];
  List<PhotoAlbum> list = [];
  List<Videos> list2 = [];
  bool userLogged = true;
  SchoolSocialMediaLinkModel? dataLink ;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getHomeData();
  }

  getHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sliderData = await AppInfoService().getSliderPhotos();
    dataLink = await AppInfoService().getSchoolSocialMediaLink();
    userLogged = prefs.getString("id") == null ? false : true;
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
            onTap: ()=>
             pushPage(context,NotificationsListScreen(),
              ),
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
            CarouselSlider(
              options: CarouselOptions(height: 150.0, autoPlay: true),
              items: list.map((i) {
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
            CarouselSlider(
              options: CarouselOptions(height: 150.0, autoPlay: true),
              items: list2.map((i) {
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
              "assets/images/logoname.jpg",
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
                  builder: (context) => JoinRequest(),
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
                    SchoolWord(
                      isAbout: true,
                    ));
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
                            ?"School policies":"السياسات المدرسيه",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ContactUsScreen(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      height: MediaQuery.of(context).size.height*0.045 ,
                      width: MediaQuery.of(context).size.width*0.3 ,
                      child: Center(
                        child: Text(
                          Localizations.localeOf(context).languageCode == "en"
                              ?"Suggestions":"الأقتراحات",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
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
                      height: MediaQuery.of(context).size.height*0.045 ,
                      width: MediaQuery.of(context).size.width*0.3 ,
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
                        "assets/images/twitter_icon.png",
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
