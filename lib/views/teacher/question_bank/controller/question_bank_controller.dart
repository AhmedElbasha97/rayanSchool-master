import 'package:get/get.dart';
import 'package:rayanSchool/models/teacher/questionBank.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../Utils/memory.dart';

class QuestionBankController extends GetxController {
  var isLoading = true.obs;
  var questions = <QuestionBankTeacher>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final result = await TeacherService().getQuestionBank(id: Get.find<StorageService>().getId);
      questions.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}