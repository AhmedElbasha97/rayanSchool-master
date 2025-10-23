import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/models/teacher/reportDetails.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/report_details_controller.dart';

class ReportsDetailScreen extends StatelessWidget {
  final String? id;
  ReportsDetailScreen({this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      ReportDetailsController(reportId: id), permanent: false
       // pass id to controller
    );

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
        }if (controller.reports.isEmpty) {
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
          padding: const EdgeInsets.all(10),
          itemCount: controller.reports.length,
          itemBuilder: (context, index) {
            final TeacherReportDetails report = controller.reports[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(report.student ?? ""),
                  Text(report.date ?? ""),
                  Html(data: report.text ?? ""),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
