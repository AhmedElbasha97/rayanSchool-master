import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Widgets/loader.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/activity_detailed_controller.dart';

class ActivityDetailedScreen extends StatelessWidget {
  final String activityId;

  const ActivityDetailedScreen({Key? key, required this.activityId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActivityDetailedController controller =
    Get.put(ActivityDetailedController(activityId), permanent: false);

    return Obx(() {
      if (controller.loading.value) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: mainColor),
            backgroundColor: const Color(0xFFdcdbdb),
            title: Image.asset(
              "assets/images/logo.png",
              scale: 4.5,
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Loader(),
        );
      }

      final details = controller.activityDetails.value;

      if (details == null) {
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
          body: Center(
            child: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english
                  ?"An error occurred while loading data.":"حدث خطأ أثناء تحميل البيانات",
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        );
      }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
            CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: "${details.image}",
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
                child: Html(data: details.description),
              )
            ],
          ),
        ),
      );
    });
  }
}
