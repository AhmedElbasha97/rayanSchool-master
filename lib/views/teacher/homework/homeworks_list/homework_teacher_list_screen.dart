import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../../../../globals/helpers.dart';
import '../../../../../Widgets/loader.dart';
import '../../../../models/teacher/homework_teacher_list_model.dart';
import '../../../loggedUser/homework/homework_details/homework_details_screen.dart';
import 'controller/homework_teacher_list_controller.dart';


class HomeworkTeacherListScreen extends StatelessWidget {
  HomeworkTeacherListScreen({Key? key}) : super(key: key);

  final controller = Get.put(HomeworkTeacherListController(), permanent: false);

  String returnDateAndTime(HomeworkTeacherListModel chat) {
    final format = DateFormat('HH:mm a');
    final formatDate = DateFormat('MMM dd');
    final dateTime = DateTime.parse(chat.date ?? "2024-02-28 11:55:54");
    if (dateTime.day == DateTime.now().day) {
      return format.format(dateTime);
    } else {
      return formatDate.format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
        title: Text(
          Get.find<StorageService>().activeLocale ==
              SupportedLocales.english
              ? "Homework list"
              : "قائمة الواجب المدرسى",
          style: TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: mainColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Loader();
          }

          if (controller.homeworkList.isEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/no_recomendation_data.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "no Homework available"
                      : "لا يوجد واجب مدرسى متوفر",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.homeworkList.length,
            itemBuilder: (context, index) {
              final item = controller.homeworkList[index];
              return InkWell(
                onTap: () => pushPage(
                  context,
                  HomeWorkDetailsScreen(id: item.id ?? ""),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade500, width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label(context,
                          en: "School assignment title:",
                          ar: "عنوان الواجب المدرسى:"),
                      _value(item.title ?? ""),
                      _label(context,
                          en: "Time to create the assignment:",
                          ar: "وقت أنشاء الواجب الدراسى:"),
                      _value(returnDateAndTime(item)),
                      _label(context, en: "class:", ar: "الفصل:"),
                      _value(item.homeworkTeacherListModelClass ?? ""),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _label(BuildContext context,
      {required String en, required String ar}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        Get.find<StorageService>().activeLocale ==
            SupportedLocales.english ? en : ar,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _value(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
