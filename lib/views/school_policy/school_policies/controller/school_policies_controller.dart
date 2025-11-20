import 'package:get/get.dart';

import '../../../../models/school_policies_model.dart';
import '../../../../services/appInfoService.dart';

class SchoolPoliciesController extends GetxController {
  var isLoading = true.obs;
  var subjects = <SchoolPoliciesModel>[].obs;

  Future<void> fetchPolicies() async {
    try {
      isLoading.value = true;
      subjects.value = await AppInfoService().getSchoolPolicies()??<SchoolPoliciesModel>[];
    } finally {
      isLoading.value = false;
    }
  }
}