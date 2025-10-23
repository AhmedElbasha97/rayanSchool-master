import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/subject.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class SubjectsController extends GetxController {
  var isLoading = true.obs;
  var subjects = <Subjects>[].obs;

  Future<void> fetchSubjects() async {
    try {
      isLoading.value = true;
      final data = await AppInfoService().getSubjects();
      subjects.assignAll(data ?? []);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }
}