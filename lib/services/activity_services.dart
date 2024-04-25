import 'package:dio/dio.dart';

import '../globals/CommonSetting.dart';
import '../models/activity_detailed_model.dart';
import '../models/activity_list_model.dart';

class ActivityService {
  String activityListLink = "${baseUrl}activity.php";
  String activityDetailsLink = "${baseUrl}art.php";
  Future<List<ActivitiesListModel>> getActivitiesList() async {
    List<ActivitiesListModel> list = [];
    Response response;
    response = await Dio().get(
      "$activityListLink",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(ActivitiesListModel.fromJson(element));
    });
    return list;
  }
  Future<ActivitiesDetailedModel> getActivitiesDetails( String activityId) async {
    ActivitiesDetailedModel data;
    Response response;
    response = await Dio().get(
      "$activityDetailsLink?dep_id=$activityId",
    );
    var resData = response.data;
    data = ActivitiesDetailedModel.fromJson(resData[0]);
    return data;
  }
}