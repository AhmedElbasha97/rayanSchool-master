// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/HomeCard.dart';
import '../../../Widgets/notification_icon.dart';
import '../../Notification/notification_list/notification_list_screen.dart';
import '../../appData/school_word/schoolWord.dart';
import '../../school_policy/school_policies/school_policies_screen.dart';
import 'controller/home_for_user_controller.dart';

class HomeLoggedInScreen extends StatelessWidget {
  final HomeForUserController controller = Get.put(HomeForUserController(), permanent: false);

  Widget build(BuildContext context) {

    return Scaffold(
      // AppBar with logo and custom colors
        appBar: AppBar(
          actions: [
            InkWell(
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
            ),
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
        body:  SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Loader();
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bcakGroundImg.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  // --- Slider Section ---
                  CarouselSlider(
                    options: CarouselOptions(height: 150, autoPlay: true),
                    items: controller.sliderData.map((i) {
                      return CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:   "https://www.alrayyanprivateschools.com/${i.img}",
                        imageBuilder: ((context, image){
                          return  Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                        placeholder: (context, image){
                          return   Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration:BoxDecoration(
                              color:  const Color(0xFFF2F0F3),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(
                                    0.0,
                                    0.0,
                                  ),
                                  blurRadius: 13.0,
                                  spreadRadius: 2.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),

                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  mainColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              ;
                        },
                        errorWidget: (context, url, error){
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            height: Get.height*0.2,
                            width: Get.width*0.7,
                            child: Image.asset("assets/images/27002.jpg",fit: BoxFit.cover,),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // --- About the school section ---
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      aboutTheSchool.tr,
                      style: appText.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            Get.to(()=>SchoolWord(),transition: Transition.rightToLeft,preventDuplicates: true);
                          },
                          title:
                          schoolWord.tr,
                          imageLink: "assets/images/school.png",
                        ),

                        HomeCard(
                          width: MediaQuery.of(context).size.width*0.45,

                          onTap: () {

                            Get.to(()=>  SchoolWord(
                              isAbout: true,
                            ),transition: Transition.rightToLeft,preventDuplicates: true);


                          },
                          title:
                          schoolVision.tr,
                          imageLink: "assets/images/vision.png",
                        ),
                        HomeCard(
                          width: MediaQuery.of(context).size.width*0.45,

                          onTap: () {
                            Get.to(()=> SchoolPoliciesScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

                          },
                          title:
                          "${Localizations.localeOf(context).languageCode == "en"
                              ?"School Policies":"السياسات المدرسية"}",
                          imageLink: "assets/images/School Policies.png",
                        ),
                      ],
                    ),
                  ),
                  //
                  // --- Albums Section ---
                  _buildAlbums(context),
                ],
              ),
            );
          },
        )
        )
    );
  }

  Widget _buildAlbums(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(photosAlbum.tr,
            style: appText.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        controller.photoAlbums.isEmpty
            ? Center(child:  Text(Get.find<StorageService>().activeLocale ==
            SupportedLocales.english
            ?"no Photos available":"لا يوجد ألبوم الصور متوفرة الآن",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20

          ),),)
            : CarouselSlider(
          options: CarouselOptions(height: 150, autoPlay: true),
          items: controller.photoAlbums.map((i) {
            return CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "${i.img}",
              imageBuilder: ((context, image){
                return  Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
              placeholder: (context, image){
                return   Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration:BoxDecoration(
                    color:  const Color(0xFFF2F0F3),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 13.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),

                ).animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 1200.ms, color:  mainColor.withAlpha(10))
                    .animate() // this wraps the previous Animate in another Animate
                    ;
              },
              errorWidget: (context, url, error){
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: Get.height*0.2,
                  width: Get.width*0.7,
                  child: Image.asset("assets/images/27002.jpg",fit: BoxFit.cover,),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Text(videosAlbum.tr,
            style: appText.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        controller.videoAlbums.isEmpty
            ? Center(child: Text(Get.find<StorageService>().activeLocale ==
            SupportedLocales.english
            ?"no Videos available":"لا يوجد ألبوم الفيديو متوفرة الآن", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20

        ),))
            : CarouselSlider(
          options: CarouselOptions(height: 150, autoPlay: true),
          items: controller.videoAlbums.map((i) {
            return CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: "${i.img}",
              imageBuilder: ((context, image){
                return  Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
              placeholder: (context, image){
                return   Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration:BoxDecoration(
                    color:  const Color(0xFFF2F0F3),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 13.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),

                ).animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 1200.ms, color:  mainColor.withAlpha(10))
                    .animate() // this wraps the previous Animate in another Animate
                    ;
              },
              errorWidget: (context, url, error){
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: Get.height*0.2,
                  width: Get.width*0.7,
                  child: Image.asset("assets/images/27002.jpg",fit: BoxFit.cover,),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
