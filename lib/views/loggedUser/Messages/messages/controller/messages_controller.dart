import 'package:get/get.dart';
import 'package:rayanSchool/models/message.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:rayanSchool/services/messagesService.dart';

import '../../../../../Utils/memory.dart';

class MessagesController extends GetxController {
  var isLoading = true.obs;
  var messages = <Messages>[].obs;
  final int type;

  MessagesController(this.type);

  Future<void> fetchMessages() async {
    isLoading.value = true;


    List<Messages> result = [];

    if (type != 1) {
      result = await ParentService().getMessages(id: Get.find<StorageService>().getId);
    } else {
      result = await MessagesService().getMessages(id: Get.find<StorageService>().getId);
    }

    messages.assignAll(result);
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }
}