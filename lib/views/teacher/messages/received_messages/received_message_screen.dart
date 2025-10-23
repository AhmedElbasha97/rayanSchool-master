import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../../../../globals/helpers.dart';
import '../../../loggedUser/Messages/message_details/message_details_screen.dart';
import 'controller/received_message_controller.dart';

class ReceivedMessageScreen extends StatelessWidget {
  const ReceivedMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReceivedMessageController(), permanent: false);

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
                  child: Image.asset("assets/images/noMessages.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english

                      ? "no messages available"
                      : "لا يوجد رسائل متوفرة الآن",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.messages.length,
          itemBuilder: (BuildContext context, int index) {
            final msg = controller.messages[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  pushPage(
                    context,
                    MessageDetailsScreen(
                      id: msg.msgId ?? "",
                      type: 3,
                    ),
                  );
                },
                title: Text(msg.title ?? ""),
                trailing: Text("${msg.date ?? ""}"),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>  Divider(color: mainColor,),
        );
      }),
    );
  }
}
