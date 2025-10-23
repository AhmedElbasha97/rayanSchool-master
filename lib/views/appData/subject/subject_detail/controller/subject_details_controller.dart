import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/subjectDetails.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class SubjectDetailsController extends GetxController {
  final String id;

  SubjectDetailsController(this.id);

  var isLoading = true.obs;
  var details = <SubjectDetails>[].obs;

  Future<void> fetchSubjectDetails() async {
    try {
      isLoading.value = true;
      final data = await AppInfoService().getSubjectDetails(id: id);
      details.assignAll(data ?? []);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSubjectDetails();
  }
}