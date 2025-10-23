import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/widgets/homeWorkCard.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../globals/commonStyles.dart';
import '../../loggedUser/question/questions_bank/controller/question_bank_controller.dart';

class QuestionBankScreen extends StatelessWidget {
  final QuestionBankController controller = Get.put(QuestionBankController(), permanent: false);

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
          return SizedBox(
            height: Get.height * 0.75,
            width: Get.width,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image(image: AssetImage("assets/images/noData.png")),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english

                      ? "no Questions available"
                      : "لا يوجد أسأله متوفره لان",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.questions?.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (_, index) {
            final q = controller.questions?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                child: HomeWorkCard(title: q?.title ?? "", date: q?.date ?? ""),
              ),
            );
          },
        );
      }),
    );
  }
}
