import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rayanSchool/models/recommendation_list_model.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendationController extends GetxController {
  var isLoading = true.obs;
  var recommendationList = <RecommendationListModel>[].obs;
  var recommendationTitle = ''.obs;
  var recommendationValue = ''.obs;

  RecommendationController({required String title, required String value}) {
    recommendationTitle.value = title;
    recommendationValue.value = value;
  }

  Future<void> fetchRecommendations() async {
    try {
      isLoading.value = true;
      final data = await ParentService()
          .getRecommendationList(typeId: recommendationValue.value);

      recommendationList.assignAll(data ?? []);
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(RecommendationListModel? item) {
    if (item == null || item.date == null) return "";

    final dateTime = DateTime.tryParse(item.date!);
    if (dateTime == null) return "";

    final formatTime = DateFormat('hh:mm a');
    final formatDate = DateFormat('MMM dd');

    if (dateTime.year == DateTime.now().year &&
        dateTime.month == DateTime.now().month &&
        dateTime.day == DateTime.now().day) {
      return formatTime.format(dateTime);
    } else {
      return formatDate.format(dateTime);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchRecommendations();
  }
}
