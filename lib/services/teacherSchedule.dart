import 'package:rayanSchool/models/schedule.dart';

import '../Utils/api_service.dart';
import '../Utils/services.dart';

class TeacherScheduleService {
  final ApiService api = ApiService();
/// Fetch teacher schedule, optionally filtered by teacher ID
  /// [teacherId] - Optional ID to filter schedule by specific teacher
  /// but this call is not used in the app
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
