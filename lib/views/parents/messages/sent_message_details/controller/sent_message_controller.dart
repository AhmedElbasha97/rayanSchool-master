import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../models/sent_message_detials_model.dart';
import '../../../../../services/ParentsService.dart';
class SentMessagesDetailsController extends GetxController{
  // Observables
  var isLoading = true.obs;
  var isSendingMessage = false.obs;
  var sentMessagesList = <SentMessageDetailsModel>[].obs;
  final String id;
  final msgController = TextEditingController();
  late final ExpansibleController standardTileController;
  SentMessagesDetailsController(this.id);
  // Lifecycle methods
  @override
  void onInit() {
    super.onInit();
    fetchSentDetailsMessages();
    standardTileController = ExpansibleController();
    standardTileController.addListener(_onTileExpansionChanged);
  }
  void _onTileExpansionChanged() {
    print(
      'Standard ExpansionTile state: ${standardTileController.isExpanded}',
    );
  }

  @override
  void dispose() {
    standardTileController.removeListener(_onTileExpansionChanged);
    standardTileController.dispose(); // Don't forget to dispose!
    super.dispose();
  }
  // Data fetching
  Future<void> fetchSentDetailsMessages() async {
    try {
      isLoading.value = true;
      final data = await ParentService().getSentMessageDetail(id:id);

      sentMessagesList.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }
// Sending reply messages
  Future<void> sentReplyMessages(context) async {
    try {
      isSendingMessage.value = true;
      String done =  await ParentService().sendReplyForMessage(id:id,msg:msgController.text);


      final msg = done == "true"
          ?
      'تم إرسال  الرساله بنجاح'
          :
      'حدث خطاء أثناء إرسال  الرساله';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: done == "true" ? Colors.green : Colors.red,
        ),
      );

      fetchSentDetailsMessages();
    } finally {
      isSendingMessage.value = false;
    }
  }

  bool isHtml(String text) {
    // Regular expression to detect HTML tags
    final htmlRegex = RegExp(r'<[^>]+>');
    return htmlRegex.hasMatch(text);
  }
  /// Format penalty date & time
  /// If the message is from today, it returns the time (e.g., "02:30 PM").
  /// If the message is from a previous day, it returns the date (e.g., "Mar 15").
  String formatDate(SentMessageDetailsModel? message) {
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