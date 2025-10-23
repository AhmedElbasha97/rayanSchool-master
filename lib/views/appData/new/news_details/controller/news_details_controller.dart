import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/newsDetails.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class NewsDetailsController extends GetxController {
  final String newsId;

  NewsDetailsController(this.newsId);

  // Observables
  var isLoading = true.obs;
  var newsDetails = <NewsDetails>[].obs;

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

  @override
  void onInit() {
    super.onInit();
    fetchNewsDetails();
  }
}
