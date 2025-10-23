import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/report_details_controller.dart';

/// Controller using GetX for managing state and API calls


class ReportsDetailScreen extends StatelessWidget {
  final String? id;

  ReportsDetailScreen({Key? key, this.id}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // Fetch data on init
    final ReportsDetailController controller = Get.put(ReportsDetailController(id), permanent: false);
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

        if (controller.reports.isEmpty) {
          return Center(
            child: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english
                  ?"No reports available now":"لا توجد تقارير متاحة الآن",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.reports.length,
          itemBuilder: (BuildContext context, int index) {
            final report = controller.reports[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${report.student}"),
                    Text("${report.date}"),
                    Text("${report.teacher ?? ""}"),
                    Html(data: "${report.text}"),
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