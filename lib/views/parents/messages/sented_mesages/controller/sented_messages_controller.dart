import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../Utils/memory.dart';
import '../../../../../models/MessageSentStudent.dart';
import '../../../../../services/ParentsService.dart';
class SentedMessagesController extends GetxController{
  var isLoading = true.obs;
  var sentMessagesList = <MessageSentStudent>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchSentMessages();
  }
  // Fetch data for
  Future<void> fetchSentMessages() async {
    try {
      isLoading.value = true;
      final data = await ParentService().getSentMessages(id:Get.find<StorageService>().getId);

      sentMessagesList.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  /// Format penalty date & time
  String formatDate(MessageSentStudent? message) {
    if (message == null || message.date == null) return "";

    final dateTime = DateTime.tryParse(message.date??"");
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
}