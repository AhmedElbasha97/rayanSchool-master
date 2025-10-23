import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rayanSchool/models/question.dart';
import 'package:rayanSchool/services/loggedUser.dart';

import '../../../../../Utils/memory.dart';

class QuestionBankController extends GetxController {
  var isLoading = true.obs;
  RxList<Question>? questions = <Question>[].obs;

  Future<void> fetchQuestions() async {
    isLoading.value = true;

    questions?.value = await LoggedUser().getQuestions(id: Get.find<StorageService>().getId)??[];
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }
}
