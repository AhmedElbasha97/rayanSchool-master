import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Widgets/loader.dart';
import '../../../globals/commonStyles.dart';
import 'controller/school_word_controller.dart';

class SchoolWord extends StatelessWidget {
  final bool isAbout;

  SchoolWord({Key? key, this.isAbout = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SchoolWordController controller =
    Get.put(SchoolWordController(isAbout: isAbout), permanent: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
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

        final data = controller.word.value;
        if (data == null) {
          return Center(
            child: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english
                  ?"No data available":"لا توجد بيانات متاحة",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView(
          children: [
            data.image ==""?SizedBox():CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:data.image ?? "",
              imageBuilder: ((context, image){
                return Container(
                  width: Get.width,
                  height: Get.height * 0.3,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
              placeholder: (context, image){
                return   Container(
                  width: Get.width,
                  height: Get.height * 0.3,
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
                  height: Get.height * 0.3,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.asset("assets/images/27002.jpg",fit: BoxFit.fitWidth,),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: data.description),
            ),
          ],
        );
      }),
    );
  }
}
