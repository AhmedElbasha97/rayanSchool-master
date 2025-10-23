import 'package:get/get.dart';
import 'package:rayanSchool/models/MessageSentStudent.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:rayanSchool/services/messagesService.dart';

import '../../../../../Utils/memory.dart';

class SentMessagesController extends GetxController {
  var isLoading = true.obs;
  var messages = <MessageSentStudent>[].obs;
  final int type;

  SentMessagesController(this.type);
  Future<void> getData(int type) async {
    isLoading.value = true;


    messages.value = type != 1
        ? await ParentService().getSentMessages(id: Get.find<StorageService>().getId)
        : await MessagesService().getSentMessages(id: Get.find<StorageService>().getId);

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getData(type);
  }
}