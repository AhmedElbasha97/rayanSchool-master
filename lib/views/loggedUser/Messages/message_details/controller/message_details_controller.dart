import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/models/messageDetails.dart';
import 'package:rayanSchool/services/messagesService.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import '../../../../../Utils/memory.dart';

class MessageDetailsController extends GetxController {
  var isLoading = true.obs;
  var messages = <MessageDetails>[].obs;
  final String id;
  final int type;

  MessageDetailsController(this.id, this.type);
  Future<void> fetchMessages() async {
    isLoading.value = true;



    List<MessageDetails> result = [];

    if (type == 3) {
      result = await TeacherService().getReceivedMessageDetails(id: Get.find<StorageService>().getId, msgId: id);
    } else if (type == 1) {
      result = await MessagesService().getMessageDetails(id: Get.find<StorageService>().getId, msgId: id);
    } else {
      result = await ParentService().getMessageDetails(id: Get.find<StorageService>().getId, msgId: id);
    }

    messages.assignAll(result);
    isLoading.value = false;
  }
  String extractTextFromHtml(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? "";
  }

  /// Alert dialog
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تنبيه"),
        content: const Text("لا يمكن فتح الرابط"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("موافق"),
          ),
        ],
      ),
    );
  }
  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }
}
