import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rayanSchool/models/penalties_list_model.dart';
import 'package:rayanSchool/services/ParentsService.dart';

class PenaltiesController extends GetxController {
  var isLoading = true.obs;
  var penaltiesList = <PenaltiesListModel>[].obs;

  /// Fetch penalties list from API
  Future<void> fetchPenalties() async {
    try {
      isLoading.value = true;
      final data = await ParentService().getPenaltiesList();
      penaltiesList.assignAll(data ?? []);
    } finally {
      isLoading.value = false;
    }
  }

  /// Format penalty date & time
  /// If the penalty is from today, show time (e.g., "02:30 PM"), otherwise show date (e.g., "Mar 15")
  String formatDate(PenaltiesListModel? penalty) {
    if (penalty == null || penalty.date == null) return "";

    final dateTime = DateTime.tryParse(penalty.date!);
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
    fetchPenalties();
  }
}
