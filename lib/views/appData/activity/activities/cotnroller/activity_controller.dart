import 'package:get/get.dart';
import 'package:rayanSchool/services/activity_services.dart';

import '../../../../../models/activity_list_model.dart';

class ActivityController extends GetxController {
  var isLoading = true.obs;
  var activityList = <ActivitiesListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      isLoading.value = true;
      final list = await ActivityService().getActivitiesList();
      activityList.assignAll(list);
    } catch (e) {
      print("Error fetching activities: $e");
      activityList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
