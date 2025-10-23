import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Widgets/loader.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/asked_question_details_controller.dart';

class AskedQuestionsDetailsScreen extends StatelessWidget {
  final String? id;
  AskedQuestionsDetailsScreen({Key? key, this.id}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // Fetch details when screen is opened
    final AskedQuestionDetailsController controller =
    Get.put(AskedQuestionDetailsController(id), permanent: false);

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

        if (controller.details.isEmpty) {
          return Center(
            child: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english
                  ?"No details available"
                  : "لا توجد تفاصيل متاحة",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.details.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final detail = controller.details[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${detail.title}"),
                    Text("${detail.date}"),
                    Text("${detail.from}"),
                    Html(data: "${detail.text}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
