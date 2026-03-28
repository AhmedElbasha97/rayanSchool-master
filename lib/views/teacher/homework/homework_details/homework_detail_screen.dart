import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/widgets/mainButton.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/home_work_details_controller.dart';

class HomeWorkDetailsScreen extends StatelessWidget {
  final String id;
  HomeWorkDetailsScreen({this.id = ""});

  @override
  Widget build(BuildContext context) {
    // Pass homework id to controller through Get.arguments
    final controller = Get.put(
      HomeworkDetailsController(hwId: id), permanent: false

    );

    return Scaffold(
      // AppBar with logo and custom colors
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
        // Display a loading indicator while data is being fetched
        if (controller.isLoading.value) {
          return Loader();
        }
        // Display an error message if data is empty
        if (controller.homework.isEmpty) {
          return Center(
            child: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english
                  ?"No details available"
                  : "لا توجد تفاصيل متاحة",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        // Display the homework details using ListView.builder
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.homework.length,
          itemBuilder: (context, index) {
            final item = controller.homework[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title ?? ""),
                  Text(item.date ?? ""),
                  Text(item.teacherName ?? ""),
                  Html(data: item.homeworkDet ?? ""),
                  if (item.homeworkFile != null)
                    controller.downloadingFile.value?Container(
                        decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                        child: Padding( padding: const EdgeInsets.all(8.0),
                          child: Center( child: CircularProgressIndicator( ), ),))
                    :Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppBtn(
                        label: download.tr,
                        onClick: () async {
                          final path = await controller.saveFile();
                          if (path != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 4),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.file_copy,
                                        color: Colors.white),
                                    const SizedBox(height: 8),
                                    Text(
                                      "${Get.find<StorageService>().activeLocale ==
                                          SupportedLocales.english? 'File saved at:' : 'تم حفظ الملف في:'} $path",
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
