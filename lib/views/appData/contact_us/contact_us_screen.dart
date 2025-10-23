import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';

import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../Widgets/text_field_widget.dart';
import 'controller/contact_us_controller.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  final ContactUsController controller = Get.put(ContactUsController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.unFocus,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: mainColor),
          backgroundColor: const Color(0xFFdcdbdb),
          title: Image.asset(
            "assets/images/logo.png",
            scale: 4.5,
          ),
          centerTitle: true,
        ),
        body: Obx(
              () => AbsorbPointer(
            absorbing: controller.isLoading.value,
            child: Form(
              key: controller.formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(complaientMsg.tr,
                      style: const TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Name
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: Get.height*0.09,
                      width: Get.width*0.95,
                      child: CustomInputField(
                        isPhoneNumber: false,
                        textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                        labelText:  userName.tr,
                        focusNode: controller.nameNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        iconOfTextField: Icon(Icons.person,
                            color: mainColor),
                        controller:controller.nameController,
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
                  const SizedBox(height: 15),

                  // Phone
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: Get.height*0.09,
                      width: Get.width*0.95,
                      child: CustomInputField(
                        isPhoneNumber: false,
                        textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                        labelText:  phoneNumber.tr,
                        focusNode: controller.phoneNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        iconOfTextField: Icon(Icons.phone,
                            color: mainColor),
                        controller:controller.phoneController,
                        onchange: controller.onPhoneUpdate,
                        validator: controller.validatePhone,
                        icon: (controller.phoneValidated.value)
                            ? (controller. phoneState.value)
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
                  const SizedBox(height: 15),

                  // Email
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: Get.height*0.09,
                      width: Get.width*0.95,
                      child: CustomInputField(
                        isPhoneNumber: false,
                        textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                        labelText:  email.tr,
                        focusNode: controller.emailNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        iconOfTextField: Icon(Icons.email,
                            color: mainColor),
                        controller:controller.emailController,
                        onchange: controller.onEmailUpdate,
                        validator: controller.validateEmail,
                        icon: (controller.emailValidated.value)
                            ? (controller. emailState.value)
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
                  const SizedBox(height: 15),

                  // Message
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 2) {
                       messageError.tr;
                      }
                      return null;
                    },
                    focusNode: controller.msgNode,
                    controller: controller.msgController,
                    maxLines: 4,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText:
                      typeMsg.tr,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Send button
                  Obx(() => controller.isLoading.value
                      ? Container(
                      decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                      child: Padding( padding: const EdgeInsets.all(8.0),
                        child: Center( child: CircularProgressIndicator( ), ),)
                  ): Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () => controller.sendMessage(context),
                        child: Container(
                          width: Get.width * 0.7,
                          height: 40,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          alignment: Alignment.center,
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                            send.tr,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
