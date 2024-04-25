import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:rayanSchool/models/schedule.dart';

class TeacherScheduleService {
  String schedule = "${baseUrl}teacher_table.php";

  Future<List<Schedule>> getSchedule({String? id}) async {
    List<Schedule> list = [];
    Response response;
    print("$schedule?teacher_id=$id");
    response = await Dio().get(
      "$schedule?teacher_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Schedule.fromJson(element));
      });
    }
    return list;
  }
}
