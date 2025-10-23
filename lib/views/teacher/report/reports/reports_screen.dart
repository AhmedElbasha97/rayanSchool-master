import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/teacher/report/report_detail/report_details_screen.dart';
import 'package:rayanSchool/models/teacher/teacherReport.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/reports_controller.dart';


class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController(), permanent: false);

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
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/noData.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? "no reports available"
                      : "لا يوجد تقارير متوفره لان",
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
          itemBuilder: (context, index) {
            final TeacherReport report = controller.reports[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  pushPage(
                    context,
                    ReportsDetailScreen(id: report.reportId),
                  );
                },
                title: Text(report.student ?? ""),
                trailing: Text(report.date ?? ""),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      }),
    );
  }
}
