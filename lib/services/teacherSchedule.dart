import 'package:rayanSchool/models/schedule.dart';

import '../Utils/api_service.dart';
import '../Utils/services.dart';

class TeacherScheduleService {
  final ApiService api = ApiService();

  Future<List<Schedule>> getSchedule({String? id}) async {
    try {
      final data = await api.request(Services.schedule,"GET",queryParameters: {
        "teacher_id":id
      });

      if (data is List) {
        return data
            .map((e) => Schedule.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getSchedule error: $e");
      return [];
    }

  }
}
