import 'package:get/get.dart';

import '../../../../../Utils/memory.dart';
import '../../../../../models/parents/reportDetails.dart';
import '../../../../../services/ParentsService.dart';

class ReportsDetailController extends GetxController {
  var isLoading = true.obs;
  var reports = <ReportDetails>[].obs;
  final String? reportId;

  ReportsDetailController(this.reportId);
  Future<void> fetchReportDetails() async {
    try {
      isLoading.value = true;


      final data = await ParentService().getReportDetails(id:  Get.find<StorageService>().getId, reportId: reportId);
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
    fetchReportDetails();
  }
}