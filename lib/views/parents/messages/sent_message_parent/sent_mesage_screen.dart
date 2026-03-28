import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/translation_key.dart';
import '../../../../Widgets/mainButton.dart';
import '../../../../globals/commonStyles.dart';
import '../../../../models/message_title_list_model.dart';
import 'controller/sent_message_controller.dart';

class SentMessageParentScreen extends StatelessWidget {
  const SentMessageParentScreen({super.key});




    @override
    Widget build(BuildContext context) {
      final controller = Get.put(SentMessageParent(), permanent: false);
      // Helper function to create consistent input decorations
      InputDecoration _inputDecoration(BuildContext ctx, String key) {
        return InputDecoration(
          prefixIcon:  Icon(Icons.message,color: mainColor),
          hintText:key,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
        );

      }
      return GestureDetector(
        // Unfocus text fields when tapping outside
        onTap: () => controller.unFocus(),
        child: Scaffold(
          // AppBar with logo and custom colors
          appBar: AppBar(
            iconTheme: IconThemeData(color: mainColor),
            backgroundColor: Color(0xFFdcdbdb),
            title: Image.asset("assets/images/logo.png", scale: 4.5),
            centerTitle: true,
          ),
          // Form to send a message
          body:Form(
            key: controller.formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              children: <Widget>[
                Text(
                  sendMessage.tr,
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                SizedBox(height: 10,),
                Obx(() =>
                    controller.isLoadingMessageTitles.value
                        ? Container(
                        width: 220,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: mainColor, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),child: const Center(child: CircularProgressIndicator()))
                        : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor, width: 1), // 👈 yellow border
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<MessageTitleModel>(
                    isExpanded: true,
                    underline: const SizedBox(), // remove the default underline

                    icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                    borderRadius: BorderRadius.circular(10),
                    value: controller.selectMessageTitle.value,
                    items: controller.messageTitles
                        .map((messageTitle) => DropdownMenuItem(
                      value: messageTitle,
                      child: Text(messageTitle.title ?? ""),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.choosingMessageTitle(value);

                    },
                  ),
                )),

                const SizedBox(height: 15),

                // Message field
                TextFormField(
                  controller: controller.msgController,

                  decoration: _inputDecoration(context, message.tr,),
                  validator: (v) => v!.isEmpty
                      ? messageError.tr
                      : null,
                ),
                const SizedBox(height: 15),

                SizedBox(height: 15),
                Obx(() => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor, width: 1), // 👈 yellow border
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: controller.type.value,
                    isExpanded: true,
                    underline: const SizedBox(), // remove the default underline

                    icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                    borderRadius: BorderRadius.circular(10),
                    items: ['اختار المرسل له', 'لأخصائي إجتماعي', 'للإشراف']
                        .map((value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.type.value = value!;
                      controller.selected.value =
                      value == 'لأخصائي إجتماعي' ? "social_worker" : "supervisor";
                    },
                  ),
                )),

                SizedBox(height: 30),
                // Send button with loading statew
                Obx(() => controller.isLoading.value
                    ?Container(
                    decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                    child: Padding( padding: const EdgeInsets.all(8.0),
                      child: Center( child: CircularProgressIndicator( ), ),)
                ):  controller.selected.value == ""
                    ? SizedBox():AppBtn(
                  onClick: () => controller.sendPressed(context),
                  label:
                  send.tr,
                )),

              ],
            ),
          ),
        ),
      );
    }
  }

