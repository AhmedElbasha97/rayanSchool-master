import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/message_details_teacher_controller.dart';

class MessageDetailsTeacherScreen extends StatelessWidget {
  final String id;
  MessageDetailsTeacherScreen({this.id = ""});

 // id will be set in constructor

  // Parse HTML and return only text


  @override
  Widget build(BuildContext context) {
    // Ensure correct id is passed to controller

    final MessageDetailsTeacherController controller =
    Get.put(MessageDetailsTeacherController(id), permanent: false);
    return Scaffold(
      appBar: AppBar(

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
        if (controller.messages.isEmpty) {
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
          padding: const EdgeInsets.all(10),
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            final item = controller.messages[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title ?? ""),
                  Text(item.date ?? ""),
                  Text(item.to ?? ""),
                  Linkify(
                    onOpen: (link) =>
                        controller.onOpenLink(context, Uri.parse(link.url)),
                    text: controller.extractTextFromHtml(item.text ?? ""),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    linkStyle: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
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
