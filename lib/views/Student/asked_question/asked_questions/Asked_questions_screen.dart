import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/Student/asked_question/asked_question_details/asked_question_details_screen.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Widgets/loader.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/asked_questions_controller.dart';

class AskedQuestions extends StatelessWidget {
  AskedQuestions({Key? key}) : super(key: key);

  final AskedQuestionsController controller =
  Get.put(AskedQuestionsController(), permanent: false);

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

        if (controller.questions?.isEmpty??true) {
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
                      ? "no questions available"
                      : "لا يوجد أسألة متوفرة الآن",
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
          itemCount: controller.questions?.length??0,
          itemBuilder: (BuildContext context, int index) {
            final question = controller.questions?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  pushPage(
                    context,
                    AskedQuestionsDetailsScreen(
                      id: question?.msgId ?? "",
                    ),
                  );
                },
                title: Text("${question?.title ?? ""}"),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return  Divider(color: mainColor);
          },
        );
      }),
    );
  }
}
