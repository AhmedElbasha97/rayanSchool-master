import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/Widgets/mainButton.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';

import '../../../../Utils/translation_key.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/file_details_controller.dart';

class FileDetailsScreen extends StatelessWidget {
  final String id;
  FileDetailsScreen({this.id = ""});



  @override
  Widget build(BuildContext context) {
    final FileDetailsController controller = Get.put(FileDetailsController(id), permanent: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset("assets/images/logo.png", scale: 4.5),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }

        if (controller.files.isEmpty) {
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
          itemCount: controller.files.length,
          padding: EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final file = controller.files[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${file.title}"),
                  Text("${file.date}"),
                  Html(data: "${file.fileDet}"),
                  file.fileLink != null
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppBtn(
                      label:download.tr,
                      onClick: () async {
                        controller.sendClick( file.fileLink??"", context);
                      },
                    ),
                  )
                      : Container(),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
