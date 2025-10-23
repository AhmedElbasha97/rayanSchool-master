import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rayanSchool/models/teacher/reportDetails.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../../Utils/memory.dart';

class ReportDetailsController extends GetxController {
  final isLoading = true.obs;
  final reports = <TeacherReportDetails>[].obs;
  final reportId;
  ReportDetailsController({required this.reportId});

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  Future<void> fetchReports() async {

    // receive id from screen
    final data = await TeacherService().getReportDetails(
      id: Get.find<StorageService>().getId,
      reportId: reportId,
    );
    reports.assignAll(data ?? []);
    isLoading.value = false;
  }
}
