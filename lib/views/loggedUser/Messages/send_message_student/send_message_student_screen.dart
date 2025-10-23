import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/models/teachers.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import '../../../../Widgets/mainButton.dart';
import '../../../../Widgets/text_field_widget.dart';
import 'controller/send_message_student_controller.dart';

class SendMessageStudentScreen extends StatelessWidget {
  final int type;
  SendMessageStudentScreen({this.type = 1});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SendMessageController(type), permanent: false);
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
      onTap: () => controller.unFocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: mainColor),
          backgroundColor: Color(0xFFdcdbdb),
          title: Image.asset("assets/images/logo.png", scale: 4.5),
          centerTitle: true,
        ),
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

              TextFormField(
                controller: controller.titleController,
                decoration: _inputDecoration(context, title.tr,),
                validator: (v) => v!.isEmpty
                    ? titleError.tr
                    : null,
              ),
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
                  items: ['اختار المرسل له', 'مدرس', 'الادارة']
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ))
                      .toList(),
                  onChanged: (value) {
                    controller.type.value = value!;
                    controller.selected.value =
                    value == 'مدرس' ? "teacher" : "admin";
                  },
                ),
              )),
              SizedBox(height: 10,),
              Obx(() => controller.selected.value == ""
                  ? SizedBox():controller.selected.value == "admin"
                  ? SizedBox()
                  : Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 1), // 👈 yellow border
                  borderRadius: BorderRadius.circular(10),
                ),
                    child: DropdownButton<Teachers>(
                                    isExpanded: true,
                                    underline: const SizedBox(), // remove the default underline

                                    icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                                    borderRadius: BorderRadius.circular(10),
                                    value: controller.selectTeacher,
                                    items: controller.teachers
                      .map((teacher) => DropdownMenuItem(
                    value: teacher,
                    child: Text(teacher.name ?? ""),
                                    ))
                      .toList(),
                                    onChanged: (value) {
                    controller.selectTeacher = value!;
                    controller.selectedTeacher.value = value;
                                    },
                                  ),
                  )),
              SizedBox(height: 30),
              Obx(() => controller.isLoading.value
                  ? Container(
                  decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                  child: Padding( padding: const EdgeInsets.all(8.0),
                    child: Center( child: CircularProgressIndicator( ), ),)
              ): AppBtn(
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
