import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/services/contactUsService.dart';

import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/validator.dart';

class ContactUsController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();
  final _validatorHelber = ValidatorHelper.instance;

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final msgController = TextEditingController();
  final phoneController = TextEditingController();

  // Focus nodes
  final nameNode = FocusNode();
  final emailNode = FocusNode();
  final msgNode = FocusNode();
  final phoneNode = FocusNode();

  // Loading state
  var isLoading = false.obs;

  //validation var
  RxBool nameState = false.obs;
  RxBool nameValidated = false.obs;
  RxBool phoneState = false.obs;
  RxBool phoneValidated = false.obs;
  RxBool emailState = false.obs;
  RxBool emailValidated = false.obs;

  // Unfocus all inputs
  void unFocus() {
    nameNode.unfocus();
    emailNode.unfocus();
    msgNode.unfocus();
    phoneNode.unfocus();
  }
  // name validations
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
  // phone validations
  void onPhoneUpdate(String? value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value == "") {
        phoneState.value = false;
      }
    });
    print("hi from update");

  }

  String? validatePhone(String?  phone) {
    print("hi from validate");
    var validatePhone = _validatorHelber.validatePhoneNumberField( phone);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (validatePhone == null &&  phone != "") {
        phoneValidated.value = true;
        phoneState.value = true;
      } else {
        phoneValidated.value = true;
      }
    });

    print("hi from validate");

    return validatePhone;
  }
  // email validations
  void onEmailUpdate(String? value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value == "") {
        emailState.value = false;
      }
    });
    print("hi from update");

  }

  String? validateEmail(String?  email) {
    print("hi from validate");
    var validateEmail = _validatorHelber.validateEmail( email);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (validateEmail == null &&  email != "") {
        emailValidated.value = true;
        emailState.value = true;
      } else {
        emailValidated.value = true;
      }
    });

    print("hi from validate");

    return validateEmail;
  }

  // Send complaint
  Future<void> sendMessage(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final done = await ContactUsService().sendComplain(
        nameController.text,
        msgController.text,
        emailController.text,
        "",
        phoneController.text,
      );

      if (done == "true") {
        _showSnackBar(
          context,
          true,
          Get.find<StorageService>().activeLocale ==
              SupportedLocales.english
              ? "The complaint has been sent successfully"
              : "تم إرسال الشكوي بنجاح",
        );
        Get.back();
      } else {
        _showSnackBar(
          context,
          false,
          Get.find<StorageService>().activeLocale ==
              SupportedLocales.english
              ? "Try sending a complaint again"
              : "حدث خطأ أثناء إرسال الشكوي",
        );
      }
    } catch (e) {
      _showSnackBar(
        context,
        false,
        Get.find<StorageService>().activeLocale ==
            SupportedLocales.english
            ? "An unexpected error occurred"
            : "حدث خطأ غير متوقع",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // SnackBar helper
  void _showSnackBar(BuildContext context, bool success, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            success ? Icons.check : Icons.close,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: success ? Colors.green : Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
