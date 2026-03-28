import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/Widgets/mainButton.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import 'controller/homework_details_controller.dart';

class HomeWorkDetailsScreen extends StatelessWidget {
  final String id;
  const HomeWorkDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeWorkDetailsController(id), permanent: false);

    return Scaffold(
      // AppBar with logo and custom colors
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset("assets/images/logo.png", scale: 4.5),
        centerTitle: true,
      ),
      body: Obx(() {
        // Display a loading indicator while data is being fetched
        if (controller.isLoading.value) {
          return Loader();
        }
        // Display an error message if data is empty
        if (controller.homeworks.isEmpty) {
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
// Display the homework details using ListView.builder
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.homeworks.length,
          itemBuilder: (context, index) {
            final hw = controller.homeworks[index];


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hw.title ?? ""),
                  Text("${hw.date ?? " "}"),
                  Text(hw.teacherName ?? ""),
                  Html(data: hw.homeworkDet ?? ""),
                Obx(() =>
                Column(
                      children: [
                        if ((hw.homeworkFile?.isNotEmpty) ?? false)
                      controller.isDownloading.value
                          ?
                              Center(
                                child: Container(
                                                      decoration: BoxDecoration(
                                  color: mainColor, shape: BoxShape.circle),
                                                      padding: const EdgeInsets.all(8),
                                                      child: const CircularProgressIndicator(),
                                                    ),
                              ): Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppBtn(
                          label: download.tr,
                          onClick: () async {
                            final ok = await controller.saveFile(context);
                            if (!ok) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Row(
                                    children: [
                                      const Icon(Icons.close,
                                          color: Colors.white),
                                      const SizedBox(width: 10),
                                      Text(
                                        Get.find<StorageService>().activeLocale ==
                                            SupportedLocales.english
                                            ? 'There is no file available for download'
                                            : 'ليس هناك ملف متاح للتحميل',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            else{

                            }
                          },
                        ),
                      )
                    else
                      Center(
                        child: Text(
                          Get.find<StorageService>().activeLocale ==
                              SupportedLocales.english
                              ? "There is no file attached to this homework."
                              : "ليس  هناك ملف مرفق مع هذا الواجب المدرسى",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    if (controller.isFileDownloaded.value)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppBtn(
                          label:  Get.find<StorageService>().activeLocale ==
                              SupportedLocales.english
                              ? "Open file" : "فتح الملف",
                          onClick: controller.openDownloadedFile,
                        ),
                      ), ],
                                ),
                )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
