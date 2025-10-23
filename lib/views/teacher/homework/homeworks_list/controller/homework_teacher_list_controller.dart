// controllers/homework_teacher_list_controller.dart
import 'package:get/get.dart';

import '../../../../../models/teacher/homework_teacher_list_model.dart';
import '../../../../../services/teachersService.dart';

class HomeworkTeacherListController extends GetxController {
  final isLoading = true.obs;
  final homeworkList = <HomeworkTeacherListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeworks();
  }

  Future<void> fetchHomeworks() async {
    isLoading.value = true;
    final list = await TeacherService().getTeacherHomeWorksList();
    homeworkList.assignAll(list ?? []);
    isLoading.value = false;
  }
}
