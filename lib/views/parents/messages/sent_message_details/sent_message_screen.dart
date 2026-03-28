import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/views/parents/messages/sent_message_details/widget/message_details_widget.dart';
import 'package:rayanSchool/views/parents/messages/sent_message_details/widget/text_field_chat_bar.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../../../../Widgets/loader.dart';

import 'controller/sent_message_controller.dart';



class SentMessagesDetailScreen extends StatelessWidget {
  SentMessagesDetailScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  // Inject controller with Behavioural type


  @override
  Widget build(BuildContext context) {
    final SentMessagesDetailsController controller = Get.put(
      SentMessagesDetailsController(id), permanent: false
  );
    return Scaffold(
      // AppBar with logo and custom colors
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
          // Display a loading indicator while data is being fetched
          if (controller.isLoading.value) {
            return Loader();
          }

          // Display an error message if data is empty
          if (controller.sentMessagesList.isEmpty) {
            return Column(
              children: [
                Expanded(

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
                ),
                TextFieldChatBar(sendMassage: (){controller.sentReplyMessages(context);},myController:controller.msgController,id: id,),

              ],
            );
          }
          // Display the list of messages using ListView.builder
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.sentMessagesList.length,
                  itemBuilder: (context, index) {
                    final item = controller.sentMessagesList[index];
                    return MessageDetailsWidget(id: id, item: item,);
                  }, separatorBuilder: (BuildContext context, int index) { return  Divider(
                  color: mainColor,
                  height: 1,
                  thickness: 2,

                ); },
                ),

              ),
              TextFieldChatBar(sendMassage: (){controller.sentReplyMessages(context);},myController:controller.msgController,id: id,),
            ],
          );
        }),
      ),
    );
  }
}