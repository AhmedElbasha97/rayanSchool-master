import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/models/teachers.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:rayanSchool/services/messagesService.dart';
import '../../../../../Utils/localization_services.dart';
import '../../../../../Utils/memory.dart';
import '../../../../../Utils/validator.dart';


class SendMessageController extends GetxController {
  var isLoading = false.obs;
  var teachers = <Teachers>[].obs;
  var selectedTeacher = Rxn<Teachers>();
  var selected = "".obs;
  var type = "اختار المرسل له".obs;
  bool formValidated = false;
  final _validatorHelber = ValidatorHelper.instance;


  final titleController = TextEditingController();
  final msgController = TextEditingController();

  final titleNode = FocusNode();
  final msgNode = FocusNode();
  RxBool nameState = false.obs;
  RxBool nameValidated = false.obs;
  final formKey = GlobalKey<FormState>();

  Teachers selectTeacher = Teachers(name: "اختر مدرس");
  final int typeOfUser;
  SendMessageController(this.typeOfUser);
  @override
  void onInit() {
    super.onInit();
    getTeachers();
  }
  void onNameUpdate(String? value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value == "") {
        nameState.value = false;
      }
    });
    print("hi from update");

  }

  String? validateName(String? name) {
    print("hi from validate");
    var validateName = _validatorHelber.validateName(name);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (validateName == null && name != "") {
        nameValidated.value = true;
        nameState.value = true;
      } else {
        nameValidated.value = true;
      }
    });

    print("hi from validate");

    return validateName;
  }

  Future<void> getTeachers() async {
    isLoading.value = true;
    var data = await MessagesService().getTeacher();
    teachers.value = [selectTeacher, ...data];
    isLoading.value = false;
  }

  Future<void> sendMessage(context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      String done =  await MessagesService().sendMessage(
          teacherId: selectedTeacher.value?.id ?? "",
          title: titleController.text,
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
    if((selectTeacher.name == "اختر مدرس")&&(selected.value != "admin")){
      showAlert(context,Get.find<StorageService>().activeLocale ==
          SupportedLocales.arabic
          ?"يجب عليك اختيار المعلم الذي سيتلقى هذه الرسالة":"you must choose the teacher who will receive this message");
    }
    if (formValidated) {
      sendMessage(context);
    }
  }
  void unFocus() {
    titleNode.unfocus();
    msgNode.unfocus();
  }
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
