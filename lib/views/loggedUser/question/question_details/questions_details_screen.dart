import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/Widgets/mainButton.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/question_details_controller.dart';

class QuestionDetailsScreen extends StatelessWidget {
  final String? id;
  QuestionDetailsScreen({this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionDetailsController(id ?? ""));

    return Scaffold(
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
        if (controller.questions.isEmpty) {
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
                      ?"No data available":"لا توجد بيانات متاحة",
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
          itemCount: controller.questions.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final question = controller.questions[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${question.title}"),
                  Text("${question.date}"),
                  Html(data: "${question.fileDet}"),
                  if (question.fileLink != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppBtn(
                        label: AppLocalizations.of(context)
                            ?.translate('download') ??
                            "",
                        onClick: () async {
                          final link = question.fileLink!;
                          if (await canLaunch(link)) {
                            await launch(link);
                          } else {
                            throw 'Could not launch $link';
                          }
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
