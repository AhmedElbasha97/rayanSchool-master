import 'package:get/get.dart';
import 'package:rayanSchool/models/teacher/messagedetails.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Utils/memory.dart';
class MessageDetailsTeacherController extends GetxController {
  final String msgId;
  MessageDetailsTeacherController(this.msgId);

  var isLoading = true.obs;
  var messages = <MessageDetailsTeacherModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessageDetails();
  }

  Future<void> fetchMessageDetails() async {
    try {

      final data = await TeacherService().getMessageDetails(id: Get.find<StorageService>().getId, msgId: msgId);
      messages.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
  String extractTextFromHtml(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? "";
  }
  Future<void> onOpenLink(BuildContext context, Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showAlert(context);
    }
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
}