import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rayanSchool/models/teacher/teacherReport.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../../Utils/memory.dart';

class ReportController extends GetxController {
  final isLoading = true.obs;
  final reports = <TeacherReport>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  Future<void> fetchReports() async {

    final data = await TeacherService().getReports(id: Get.find<StorageService>().getId);
    reports.assignAll(data ?? []);
    isLoading.value = false;
  }
}
