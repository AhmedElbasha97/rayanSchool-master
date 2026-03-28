import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/newsDetails.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class NewsDetailsController extends GetxController {
  NewsDetailsController(this.newsId);
  final String newsId;
  // Observables
  var isLoading = true.obs;
  var newsDetails = <NewsDetails>[].obs;
// Initialize data fetching when the controller is created
  @override
  void onInit() {
    super.onInit();
    fetchNewsDetails();
  }
  // Fetch data
  Future<void> fetchNewsDetails() async {
    try {
      isLoading.value = true;
      final result = await AppInfoService().getNewsDetails(id: newsId);
      newsDetails.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

}
