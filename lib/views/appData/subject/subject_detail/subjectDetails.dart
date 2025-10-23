import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/subject_details_controller.dart';

class SubjectDetailsScreen extends StatelessWidget {
  final String? id;

  SubjectDetailsScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SubjectDetailsController controller =
    Get.put(SubjectDetailsController(id ?? ""), permanent: false);

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }

        if (controller.details.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                Get.find<StorageService>().activeLocale ==
                    SupportedLocales.english
                    ?"No data available":"لا توجد بيانات متاحة",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.details.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final detail = controller.details[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detail.image ==""?SizedBox():CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:detail.image ?? "",
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
                    const SizedBox(height: 10),
                    Text(
                      "${detail.title}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Html(data: "${detail.description}"),
                    const SizedBox(height: 20),
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
