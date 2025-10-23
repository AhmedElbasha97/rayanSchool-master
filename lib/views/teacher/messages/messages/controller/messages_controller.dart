import 'package:get/get.dart';
import 'package:rayanSchool/models/teacher/sentMessages.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Utils/memory.dart';

class MessagesTeacherController extends GetxController {
  var isLoading = true.obs;
  var messages = <SentMessagesTeacher>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      final data = await TeacherService().getSentMessages(id: Get.find<StorageService>().getId);
      messages.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
}
