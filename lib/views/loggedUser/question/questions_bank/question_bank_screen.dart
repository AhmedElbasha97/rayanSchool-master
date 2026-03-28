import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/homeWorkCard.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/views/loggedUser/question/question_details/questions_details_screen.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/question_bank_controller.dart';

// This screen displays a list of questions for logged-in users. It uses the GetX package for state management and localization services to support multiple languages. The screen includes an AppBar with a logo and custom colors, and it handles loading states and empty data scenarios gracefully.
//but the school asked to remove this screen from the app so i just hide it and keep the code for future use if they want to add it again
class QuestionBankScreen extends StatelessWidget {
  final QuestionBankController controller = Get.put(QuestionBankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with logo and custom colors
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset("assets/images/logo.png", scale: 4.5),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }

        if (controller.questions?.isEmpty??true) {
          // Display an empty state if there are no questions available
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
        // Display the questions list using ListView.builder

        return ListView.builder(
          itemCount: controller.questions?.length??0,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final question = controller.questions?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(QuestionDetailsScreen(id: question?.id ?? ""),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                child: HomeWorkCard(
                  title: question?.title ?? "",
                  date: question?.date ?? "",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
