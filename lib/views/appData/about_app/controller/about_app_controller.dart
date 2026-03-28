import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class AboutAppController extends GetxController {
  var word = Rxn<AboutSchool>(); // Observable nullable object
  var loading = true.obs;
//fetch about app data and update the loading state accordingly
  @override
  void onInit() {
    super.onInit();
    fetchAboutApp();
  }
//fetch about app data and update the loading state accordingly
  Future<void> fetchAboutApp() async {
    try {
      loading.value = true;
      word.value = await AppInfoService().getaboutApp();
    } catch (e) {
      print("Error fetching about app data: $e");
    } finally {
      loading.value = false;
    }
  }
}