// views/photos_album.dart
// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/models/AppInfo/photo.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';
import 'package:rayanSchool/globals/helpers.dart';

import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../globals/commonStyles.dart';
import 'controller/photo_album_controller.dart';

class PhotosAlbum extends StatelessWidget {
  final String? id;
  final String? title;
  final bool isImg;

  const PhotosAlbum({
    Key? key,
    this.id,
    this.title,
    this.isImg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      PhotosAlbumController(albumId: id ?? '', isImg: isImg),
         permanent: false);

    return Scaffold(
      appBar: AppBar(title: Text(title ?? ''),  iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }

        final List<Photo> photos = controller.photos;
        final List<Videos> videos = controller.videos;
        final itemCount = isImg ? photos.length : videos.length;

        if (itemCount == 0) {
          return Container(
            height: Get.height * 0.75,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/noData.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ?"No data available":"لا توجد بيانات متاحة",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: itemCount,
          itemBuilder: (_, index) {
            final imageUrl =
            isImg ? photos[index].img : videos[index].img;
            final videoLink =
            !isImg ? videos[index].link ?? '' : null;

            return InkWell(
              onTap: () {
                if (!isImg && videoLink != null && videoLink.isNotEmpty) {
                  launchURL(videoLink);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:imageUrl??"",
                  imageBuilder: ((context, image){
                    return Container(
                      width: Get.width,
                      height: Get.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                      ),
                    );
                  }),
                  placeholder: (context, image){
                    return   Container(
                      width: Get.width,
                      height: Get.height * 0.2,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      width: Get.width,
                      height: Get.height * 0.2,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset("assets/images/27002.jpg",fit: BoxFit.fitWidth,),
                    );
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
