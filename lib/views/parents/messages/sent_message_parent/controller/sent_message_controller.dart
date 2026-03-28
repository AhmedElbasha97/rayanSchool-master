import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Utils/localization_services.dart';
import '../../../../../Utils/memory.dart';
import '../../../../../models/message_title_list_model.dart';
import '../../../../../services/ParentsService.dart';
import '../../../../../services/messagesService.dart';

class SentMessageParent extends GetxController{
  // Observables
  var isLoading = false.obs;
  var isLoadingMessageTitles = true.obs;
  var messageTitles = <MessageTitleModel>[].obs;
  var selectedMessageDetails = Rxn<MessageTitleModel>();
  var selected = "".obs;
  var type = "اختار المرسل له".obs;
  bool formValidated = false;

  final titleController = TextEditingController();
  final msgController = TextEditingController();

  final titleNode = FocusNode();
  final msgNode = FocusNode();
  RxBool nameState = false.obs;
  RxBool nameValidated = false.obs;
  final formKey = GlobalKey<FormState>();
  var selectMessageTitle =  Rxn<MessageTitleModel>();
  // Lifecycle methods
  @override
  void onInit() {
    super.onInit();
    selectMessageTitle.value =  MessageTitleModel(title: Get.find<StorageService>().activeLocale ==
        SupportedLocales.arabic
        ?"اختر عنوان الرساله":"choose message title");
    getMessagesTitle();

  }

// fetch message titles , add selected title to the list and update the loading state accordingly
  Future<void> getMessagesTitle() async {
    isLoadingMessageTitles.value = true;
    var data = await MessagesService().getMessageTitles();
    messageTitles.value = [selectMessageTitle.value!, ...data];
    isLoadingMessageTitles.value = false;
  }
// update the selected message title and details when a new title is chosen
   void choosingMessageTitle( MessageTitleModel? chosenMessageTitle){
    selectMessageTitle.value = chosenMessageTitle;
    selectedMessageDetails.value = chosenMessageTitle;
    update();
  }
  // send the message if the form is valid, show a snackbar with the result, and navigate back if successful
  Future<void> sendMessage(context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      String done = await ParentService().sendMessage(

          title:  selectedMessageDetails.value?.title?? "",
          msg: msgController.text,
          id: Get.find<StorageService>().getId,
          type: selected.value);

      isLoading.value = false;
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
      if (done == "true") Get.back();

    }
  }
  Future<void> sendPressed(context) async {
    formValidated = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(selected.value == ""){
      showAlert(context,Get.find<StorageService>().activeLocale ==
          SupportedLocales.arabic
          ?"يجب عليك اختيار من سيتلقى هذه الرسالة":"you must choose who will receive this message");
    }
    if (formValidated) {
      sendMessage(context);
    }
  }
  // Unfocus the title and message input fields
  void unFocus() {
    titleNode.unfocus();
    msgNode.unfocus();
  }
  // Show an alert dialog with a custom message
  void showAlert(BuildContext context,String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  Text(Get.find<StorageService>().activeLocale ==
            SupportedLocales.english
            ?"Alert":"تنبيه"),
        content:  Text(msg,),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:  Text(Get.find<StorageService>().activeLocale ==
                SupportedLocales.english
                ?"ok":"موافق"),
          ),
        ],
      ),
    );
  }
}