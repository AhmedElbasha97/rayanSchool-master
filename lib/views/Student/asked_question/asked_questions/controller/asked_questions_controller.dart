import 'package:get/get.dart';
import 'package:rayanSchool/models/Student/AskedQuestion.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Utils/memory.dart';

class AskedQuestionsController extends GetxController {
  var isLoading = true.obs;
   RxList<AskedQuestion>? questions = <AskedQuestion>[].obs;

  /// Fetch asked questions for the logged-in student
  Future<void> fetchAskedQuestions() async {
    try {
      isLoading.value = true;
      final data = await LoggedUser().getAskedQuestions(id: Get.find<StorageService>().getId);
      questions?.assignAll(data != null?data:[]);
    } catch (e) {
      print("Error fetching asked questions: $e");
      questions?.clear();
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchAskedQuestions();
  }
}