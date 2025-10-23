import 'package:get/get.dart';
import 'package:rayanSchool/models/questionDetails.dart';
import 'package:rayanSchool/services/loggedUser.dart';

import '../../../../../Utils/memory.dart';

class QuestionDetailsController extends GetxController {
  final String qId;
  QuestionDetailsController(this.qId);

  var isLoading = true.obs;
  var questions = <QuestionDetails>[].obs;

  Future<void> fetchDetails() async {
    isLoading.value = true;

    questions.value =
    await LoggedUser().getQuestionsDetails(id: Get.find<StorageService>().getId , qId: qId);
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchDetails();
  }
}
