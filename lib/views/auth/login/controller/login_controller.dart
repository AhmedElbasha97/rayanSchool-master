import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/services/authService.dart';
import 'package:rayanSchool/views/home/home_for_user/controller/home_for_user_controller.dart';

import '../../../../Utils/validator.dart';
import '../../../home/home_for_user/home_for_user_screen.dart';

class LoginController extends GetxController {
  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _validatorHelber = ValidatorHelper.instance;
  final formKey = GlobalKey<FormState>();

  // State variables
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  bool formValidated = false;

  RxBool nameState = false.obs;
  RxBool nameValidated = false.obs;
  RxBool passwordState = false.obs;
  RxBool passwordValidated = false.obs;

  // Dropdown
  var selectedType = "اختار نوع المستخدم".obs;
  var accountType = "".obs;

  // Login method
  Future<void> login(BuildContext context) async {

    if (accountType.value.isEmpty) {
      _showAlert(context);
      return;
    }

    isLoading.value = true;

    final msg = await AuthService().login(
      password: passwordController.text,
      userName: usernameController.text,
      type: accountType.value,
    );

    isLoading.value = false;

    if (msg == "done") {
      Get.offAll(() => HomeLoggedInScreen());
    } else {
      Get.snackbar(
        "خطأ",
        msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void togglePasswordVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPasswordVisible.value = !isPasswordVisible.value;
    });
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
  void onPasswordUpdate(String? value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value == "") {
        passwordState.value = false;
      }
    });
    print("hi from update");

  }

  String? validatePassword(String? password) {
    print("hi from validate");
    var validatePassword = _validatorHelber.validateName(password);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (validatePassword == null && password != "") {
        passwordValidated.value = true;
        passwordState.value = true;
      } else {
        passwordValidated.value = true;
      }
    });

    print("hi from validate");

    return validatePassword;
  }

  void updateAccountType(String? value) {
    selectedType.value = value??"";
    accountType.value = value == "ولي امر"
        ? "PARENTS"
        : value == "مدرس"
        ? "TEACHER"
        : "STUDENT";
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تنبيه"),
        content: const Text("يجب اختيار نوع المستخدم"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("موافق"),
          ),
        ],
      ),
    );
  }
  Future<void> sendPressed(context) async {
    formValidated = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (accountType.value.isEmpty) {
      _showAlert(context);
      return;
    }
    if (formValidated) {
      login(context);
    }
  }

  // late String _optCode;
  Future errorDialog(String err) async {
    return Get.defaultDialog(
        title: "error /n tryAgain.tr ",
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        middleText: err);
  }
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}