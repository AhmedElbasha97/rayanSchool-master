import 'package:get/get.dart';

import '../../../../../Utils/memory.dart';
import '../../../../../models/parents/reports.dart';
import '../../../../../services/ParentsService.dart';

class ReportController extends GetxController {
  var isLoading = true.obs;
  var reports = <Report>[].obs;

  Future<void> fetchReports() async {
    try {
      isLoading.value = true;

      final data = await ParentService().getReports(id: Get.find<StorageService>().getId);
      reports.assignAll(data);
    } catch (e) {
      print("Error fetching reports: $e");
      reports.clear();
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }
}