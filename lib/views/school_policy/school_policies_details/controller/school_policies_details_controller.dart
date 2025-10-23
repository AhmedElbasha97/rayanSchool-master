import 'package:get/get.dart';

import '../../../../models/school_policies_details_model.dart';
import '../../../../services/appInfoService.dart';



class SchoolPoliciesDetailsController extends GetxController {
  var isLoading = true.obs;
  var details = <SchoolPoliciesDetailsModel>[].obs;

  Future<void> fetchDetails(String id) async {
    try {
      isLoading.value = true;
      details.value = await AppInfoService().getSchoolPoliciesDetails(id: id);
    } finally {
      isLoading.value = false;
    }
  }
}
