import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/views/loggedUser/Messages/message_details/message_details_screen.dart';

import '../../../../globals/commonStyles.dart';
import 'controller/messages_controller.dart';

class MessagesScreen extends StatelessWidget {
  final int type;
  MessagesScreen({this.type = 1, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final MessagesController controller = Get.put(MessagesController(type), permanent: false);

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
            width:Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/noMessages.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Localizations.localeOf(context).languageCode == "en"
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
          itemBuilder: (context, index) {
            final msg = controller.messages[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Get.to( ()=>MessageDetailsScreen(
                    type: type,
                    id: msg.msgId ?? "",
                  ),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                title: Text(msg.title ?? ""),
                trailing: Text("${msg.date ?? ""}"),
              ),
            );
          },
          separatorBuilder: (_, __) =>  Divider(color: mainColor,),
        );
      }),
    );
  }
}
