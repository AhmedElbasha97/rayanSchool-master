import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class PrivacyPolicyController extends GetxController {
  var isLoading = true.obs;
  var policy = Rxn<AboutSchool>();

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      policy.value = await AppInfoService().getPrivacyPolicy();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }
}
