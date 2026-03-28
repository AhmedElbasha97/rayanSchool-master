import 'package:get/get.dart';
import 'package:rayanSchool/models/activity_detailed_model.dart';
import 'package:rayanSchool/services/activity_services.dart';

class ActivityDetailedController extends GetxController {
  final String activityId;

  ActivityDetailedController(this.activityId);

  var activityDetails = Rxn<ActivitiesDetailedModel>();
  var loading = true.obs;
  @override
  void onInit() {
    super.onInit();
    fetchActivityDetails();
  }
//fetch activity details based on the provided activity ID and update the loading state accordingly
  Future<void> fetchActivityDetails() async {
    try {
      loading.value = true;
      activityDetails.value = await ActivityService().getActivitiesDetails(activityId);
    } catch (e) {
      print("Error fetching activity details: $e");
    } finally {
      loading.value = false;
    }
  }
}
