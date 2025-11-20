import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rayanSchool/models/parents/attendance.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController extends GetxController {
  var isLoading = true.obs;
  var attendanceList = <Attendance>[].obs;

  /// Fetch attendance list from API
  Future<void> fetchAttendance() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("id");

      if (id != null) {
        final data = await ParentService().getAttendance(id: id);
        attendanceList.assignAll(data);
      } else {
        attendanceList.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Format attendance date & time
  String formatDateOrTime(Attendance? attendance) {
    if (attendance == null || attendance.date == null) return "";
    final dateTime = DateTime.tryParse(attendance.date.toString());
    if (dateTime == null) return "";

    final formatTime = DateFormat('hh:mm a');
    final formatDate = DateFormat('MMM dd');

    if (dateTime.day == DateTime.now().day &&
        dateTime.month == DateTime.now().month &&
        dateTime.year == DateTime.now().year) {
      return formatTime.format(dateTime);
    } else {
      return formatDate.format(dateTime);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
  }
}