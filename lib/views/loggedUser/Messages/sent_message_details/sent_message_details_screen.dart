import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/sent_message_details_controller.dart';

class SentMessageDetails extends StatelessWidget {
  final int type;
  final String? id;

  SentMessageDetails({this.id, this.type = 1});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SentMessageDetailsController(type, id), permanent: false);

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
        if (controller.msg.isEmpty) {
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
          padding: EdgeInsets.all(10),
          itemCount: controller.msg.length,
          itemBuilder: (BuildContext context, int index) {
            final message = controller.msg[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${message.title}"),
                    Text("${message.date}"),
                    Text("${message.from ?? ""}"),
                    Html(data: "${message.text}"),
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
