import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/views/teacher/messages/messssage_details/message_details_teacher_screen.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/messages_controller.dart';

class MessagesTeacherScreen extends StatelessWidget {
  final MessagesTeacherController controller =
  Get.put(MessagesTeacherController(), permanent: false);

  @override
  Widget build(BuildContext context) {
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

        if (controller.messages.isEmpty) {
          return SizedBox(
            height: Get.height * 0.75,
            width: Get.width,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image(image: AssetImage("assets/images/noMessages.png")),
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
          separatorBuilder: (_, __) =>  Divider(color: mainColor,),
          itemBuilder: (context, index) {
            final msg = controller.messages[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Get.to(()=>MessageDetailsTeacherScreen(id: msg.msgId ?? ""),transition: Transition.rightToLeft,preventDuplicates: false);
                },
                title: Text(msg.title ?? ""),
                trailing: Text(msg.date ?? ""),
              ),
            );
          },
        );
      }),
    );
  }
}
