import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class SchoolPolicyController extends GetxController {

  var isLoading = true.obs;
  var policy = Rxn<AboutSchool>();
  @override
  void onInit() {
    super.onInit();
    fetchPolicy();
  }
  Future<void> fetchPolicy() async {
    try {
      isLoading.value = true;

      policy.value = await AppInfoService().getSchoolPolicy();

    } finally {
      isLoading.value = false;
    }
  }


}