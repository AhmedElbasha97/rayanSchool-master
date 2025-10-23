import 'package:get/get.dart';
import 'package:rayanSchool/models/Student/AskedQuestionDetails.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Utils/memory.dart';

class AskedQuestionDetailsController extends GetxController {
  var isLoading = true.obs;
  var details = <AskedQuestionDetails>[].obs;
  final String? qId;

  AskedQuestionDetailsController(this.qId);

  /// Fetch asked question details based on question ID
  Future<void> fetchDetails() async {
    try {
      isLoading.value = true;

      final data =
      await LoggedUser().getAskedQuestionsDetails(id: Get.find<StorageService>().getId, qid: qId);

      details.assignAll(data);
    } catch (e) {
      print("Error fetching question details: $e");
      details.clear();
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchDetails();
  }

}
