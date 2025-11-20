// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'package:rayanSchool/views/other/photo_album/photos_album_screen.dart';
import '../../Utils/localization_services.dart';
import '../../Utils/memory.dart';
import '../../Widgets/loader.dart';
import '../../globals/commonStyles.dart';
import 'controller/albums_controller.dart';

class AlbumsScreen extends StatelessWidget {
  final bool isImg;
  AlbumsScreen({this.isImg = true});

  final AlbumsController controller = Get.put(AlbumsController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    controller.getData(isImg);

    return Scaffold(
      appBar:  AppBar(

    iconTheme: new IconThemeData(color: mainColor),
    backgroundColor: Color(0xFFdcdbdb),
    title: Image.asset(
    "assets/images/logo.png",
    scale: 4.5,
    ),
    centerTitle: true,
    ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }

        if (controller.isEmptyList.value) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/noData.png"),
                ),
                SizedBox(height: 20),
                Text(
                  isImg?
        Get.find<StorageService>().activeLocale ==
        SupportedLocales.english
        ? "no Photos available"
                      : "لا يوجد ألبوم الصور متوفرة الآن"
                      : Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english?
                  "no Videos available"
                      : "لا يوجد ألبوم الفيديو متوفرة الآن",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ],
            ),
          );
        }



        return isImg? ListView.builder(
          itemCount: controller.list?.length??0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(PhotosAlbum(
                    id:controller.list?[index].id ?? "",
                    isImg: isImg,
                    title: controller.list?[index].title ?? "",
                  ),transition: Transition.rightToLeft,preventDuplicates: true);


                },
                child: Column(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "${controller.list?[index].img?? ""}",
                      imageBuilder: ((context, image){
                        return   Container(
                          width: Get.width,
                          height: Get.height * 0.2,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:image,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                          width: Get.width,
                          height: Get.height * 0.2,
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Image.asset("assets/images/27002.jpg",fit: BoxFit.fitWidth,),
                        );
                      },
                    ),

                    SizedBox(height: 10),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          child: Text(
                            "${controller.list?[index].title ?? ""}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ):ListView.builder(
          itemCount: controller.listVideos?.length??0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(PhotosAlbum(
                    id:controller.listVideos?[index].id ?? "",
                    isImg: isImg,
                    title: controller.listVideos?[index].title ?? "",
                  ),transition: Transition.rightToLeft,preventDuplicates: true);


                },
                child: Column(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:"${controller.listVideos?[index].img?? ""}",
                      imageBuilder: ((context, image){
                        return   Container(
                          width: Get.width,
                          height: Get.height * 0.2,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:image,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                          width: Get.width,
                          height: Get.height * 0.2,
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Image.asset("assets/images/27002.jpg",fit: BoxFit.fitWidth,),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 200,
                          child: Text(
                            "${controller.listVideos?[index].title ?? ""}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
