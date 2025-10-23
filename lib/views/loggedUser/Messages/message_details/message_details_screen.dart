import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../../../../models/messageDetails.dart';
import 'controller/message_details_controller.dart';

class MessageDetailsScreen extends StatelessWidget {
  final String id;
  final int type;

  MessageDetailsScreen({this.id = "", this.type = 1, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Load data when screen opens
    final MessageDetailsController controller = Get.put(MessageDetailsController(id,type), permanent: false);

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
            MessageDetails message = controller.messages[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message.title ?? ""),
                    Text("${message.date ?? " "}"),
                    Text(message.from ?? ""),
                    Linkify(
                      onOpen: (link) async {
                        Uri uri = Uri.parse(link.url);
                        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                          controller.showAlert(context);
                        }
                      },
                      text: controller.extractTextFromHtml(message.text ?? ""),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      linkStyle: const TextStyle(
                          color: Colors.blue, decoration: TextDecoration.underline),
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

  /// Extract plain text from HTML

}
