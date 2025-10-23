import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/views/parents/report/report_details/ReportDetailsScreen.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/reports_controller.dart';

/// Controller for managing reports with GetX


class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);

  final ReportController controller = Get.put(ReportController(), permanent: false);

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

        if (controller.reports.isEmpty) {
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
                      ? "no reports available"
                      : "لا يوجد تقارير متوفرة الآن.",
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
          itemCount: controller.reports.length,
          itemBuilder: (BuildContext context, int index) {
            final report = controller.reports[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Get.to(()=>ReportsDetailScreen(id: report.reportId),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                title: Text("${report.teacher}"),
                trailing: Text("${report.date}"),
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