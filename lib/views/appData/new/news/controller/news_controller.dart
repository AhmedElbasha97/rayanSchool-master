import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/News.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class NewsController extends GetxController {
  // Observables
  var isLoading = true.obs;
  RxList<News> newsList = <News>[].obs;

  // Fetch data
  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      final result = await AppInfoService().getNews();
      newsList.assignAll(result?.toList()??[]);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }
}
