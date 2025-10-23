import 'package:get/get.dart';
import 'package:rayanSchool/models/MessageDetailsStudent.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:rayanSchool/services/messagesService.dart';
import '../../../../../Utils/memory.dart';

class SentMessageDetailsController extends GetxController {
  var isLoading = true.obs;
  var msg = <MessageDetailsStudent>[].obs;
  final int type;
  final String? id;

  SentMessageDetailsController(this.type, this.id);
  Future<void> getData() async {
    isLoading.value = true;
    msg.value = type != 1
        ? await ParentService().getSentMessageDetails(id: Get.find<StorageService>().getId, msgId: id)
        : await MessagesService().getSentMessageDetails(id: Get.find<StorageService>().getId, msgId: id);

    isLoading.value = false;
  }
  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
