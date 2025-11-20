import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/views/parents/messages/sented_mesages/widget/user_chat_widget.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../../../../Widgets/loader.dart';

import '../sent_message_details/sent_message_screen.dart';
import 'controller/sented_messages_controller.dart';

class SentedMessagesScreen extends StatelessWidget {
  SentedMessagesScreen({Key? key}) : super(key: key);

  // Inject controller with Behavioural type
  final SentedMessagesController controller = Get.put(
      SentedMessagesController(), permanent: false
  );

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Loader();
          }

          if (controller.sentMessagesList.isEmpty) {
            return SizedBox(
              height: Get.height,
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

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.sentMessagesList.length,
            itemBuilder: (context, index) {
              final item = controller.sentMessagesList[index];
              return UserChatWidget(userChat: item, press: () { Get.to(SentMessagesDetailScreen(id: item.msgId??"",),transition: Transition.rightToLeft,preventDuplicates: true);  },);
            },
          );
        }),
      ),
    );
  }
}