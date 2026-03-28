import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/Widgets/mainButton.dart';

import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../Widgets/text_field_widget.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        // AppBar with logo and custom colors
        appBar: AppBar(

          iconTheme: new IconThemeData(color: mainColor),
          backgroundColor: Color(0xFFdcdbdb),
          title: Image.asset(
            "assets/images/logo.png",
            scale: 4.5,
          ),
          centerTitle: true,
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        // Form to handle user input and validation
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset("assets/images/logoname.png"),
              const SizedBox(height: 20),
              // Password
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: Get.height*0.09,
                  width: Get.width*0.95,
                  child: CustomInputField(
                    isPhoneNumber: false,
                    textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                    labelText:  userName.tr,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    iconOfTextField: Icon(Icons.person,
                        color: mainColor),
                    controller:controller.usernameController,
                    onchange: controller.onNameUpdate,
                    validator: controller.validateName,
                    icon: (controller.nameValidated.value)
                        ? (controller.nameState.value)
                        ? const Icon(Icons.check_rounded,
                        color: kSuccessColor)
                        : const Icon(
                      Icons.close_outlined,
                      color: kErrorColor,
                    )
                        : null,
                    hasGreenBorder: false, hasborder: true,
                  ),
                ),
              ),),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: Get.height*0.09,
                  width: Get.width*0.95,
                  child: CustomInputField(
                    isPhoneNumber: false,
                    textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                    labelText:  password.tr,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    iconOfTextField: Icon(Icons.password
                        ,

                        color: mainColor),
                    obsecure: !controller.isPasswordVisible.value,
                    controller:controller.passwordController,
                    onchange: controller.onPasswordUpdate,
                    validator: controller.validatePassword,
                      icon: IconButton(
                        // Based on passwordVisible state choose the icon
                        icon: SizedBox(
                          width: Get.width*0.1,
                          child: Row(
                            children: [
                              Icon(
                                  (controller.passwordValidated.value)
                                      ? (controller.passwordState.value)
                                      ?Icons.check_rounded:Icons.close_outlined:Icons.close_outlined,
                                  color: (controller.passwordValidated.value)
                                      ? (controller.passwordState.value)
                                      ?kSuccessColor:kErrorColor:Colors.white),

                              Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: mainColor,
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          controller.togglePasswordVisibility();
                        },
                      ),
                    hasGreenBorder: false, hasborder: true,
                  ),
                ),
              ),),


              const SizedBox(height: 20),

              // Dropdown for user type selection
              Obx(() => Container(
                width: 220,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  value: controller.selectedType.value,
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: <String>[
                    'اختار نوع المستخدم',
                    'ولي امر',
                    'مدرس',
                    'طالب',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (e){controller.updateAccountType(e);},
                ),
              )),

              const SizedBox(height: 35),

              // Login button
              Obx(() => controller.isLoading.value
                  ? Container(
                  decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                  child: Padding( padding: const EdgeInsets.all(8.0),
                    child: Center( child: CircularProgressIndicator( ), ),)
              ): AppBtn(
                onClick: () => controller.sendPressed(context),
                label:
               login.tr,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
