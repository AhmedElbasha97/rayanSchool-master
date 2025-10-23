import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rayanSchool/models/recommendation_list_model.dart';
import 'package:rayanSchool/services/ParentsService.dart';

class RecommendationAcademicController extends GetxController {
  var isLoading = true.obs;
  var recommendationList = <RecommendationListModel>[].obs;
  var recommendationTitle = "توصيات أكاديمية".obs;
  var recommendationValue = "1";

  /// Fetch recommendation list from API
  Future<void> fetchRecommendations() async {
    try {
      isLoading.value = true;

      // Get user type from shared preferences


      // Fetch data from API
      final data = await ParentService()
          .getRecommendationList(typeId: recommendationValue);

      recommendationList.assignAll(data ?? []);
    } finally {
      isLoading.value = false;
    }
  }

  /// Format recommendation date & time
  String formatDate(RecommendationListModel? item) {
    if (item == null || item.date == null) return "";

    final dateTime = DateTime.tryParse(item.date!);
    if (dateTime == null) return "";

    final formatTime = DateFormat('hh:mm a');
    final formatDate = DateFormat('MMM dd');

    if (dateTime.day == DateTime.now().day &&
        dateTime.month == DateTime.now().month &&
        dateTime.year == DateTime.now().year) {
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
