import 'package:rayanSchool/Utils/services.dart';

import '../Utils/api_service.dart';
import '../models/activity_detailed_model.dart';
import '../models/activity_list_model.dart';

class ActivityService {


  // Use the enhanced centralized ApiService
  final ApiService api = ApiService();

  /// Get activities list using ApiService
  Future<List<ActivitiesListModel>> getActivitiesList() async {
    try {
      final data = await api.request(Services.activityListLink,"GET");

      if (data is List) {
        return data
            .map((e) => ActivitiesListModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getActivitiesList error: $e");
      return [];
    }
  }

  /// Get activity details using ApiService
  Future<ActivitiesDetailedModel?> getActivitiesDetails(String activityId) async {
    try {
      final data = await api.request(Services.activityDetailsLink,"GET",queryParameters: {"dep_id":activityId});

      if ( data.isNotEmpty) {
        return ActivitiesDetailedModel.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getActivitiesDetails error: $e");
      return null;
    }
  }

  /// Fetch list and details concurrently for better performance
  Future<Map<String, dynamic>> getActivitiesListAndDetails(String activityId) async {
    try {
      final results = await Future.wait([
        getActivitiesList(),
        getActivitiesDetails(activityId),
      ]);

      return {
        "list": results[0],
        "details": results[1],
      };
    } catch (e) {
      print("❌ Error fetching combined data: $e");
      return {
        "list": [],
        "details": null,
      };
    }
  }
}
