import 'package:get/get.dart';
import 'package:rayanSchool/models/message.dart';
import 'package:rayanSchool/services/teachersService.dart';
import '../../../../../Utils/memory.dart';

class ReceivedMessageController extends GetxController {
  var isLoading = true.obs;
  var messages = <Messages>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {

      final data = await TeacherService().getReceivedMessages(id: Get.find<StorageService>().getId);
      messages.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
}
