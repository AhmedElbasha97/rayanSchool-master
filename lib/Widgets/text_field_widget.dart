// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Utils/Colors_File.dart';
import '../Utils/constant.dart';
import '../Utils/localization_services.dart';
import '../Utils/memory.dart';
import '../globals/commonStyles.dart';



class CustomInputField extends StatelessWidget {
  CustomInputField(
      {super.key,
        required this.labelText,
        required this.icon,
        this.onchange,
        this.controller,
        this.keyboardType,
        this.validator,
        this.isAutoValidate = true,
        this.onFieldSubmitted,
        this.onSaved,
        this.validated,
        this.obsecure = false,
        this.focusNode,
        this.textInputAction,
        required this.hasGreenBorder,
        required this.hasborder,
        this.suffixText = " ",
        this.textAligning = TextAlign.right, this.iconOfTextField, required this.isPhoneNumber});
  final String labelText;
  final  icon;
  final iconOfTextField;
  var  validated;
  final onchange;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final bool isAutoValidate;
  final TextInputType? keyboardType;
  final bool obsecure;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool hasGreenBorder;
  final bool hasborder;
  final String? suffixText;
  final TextAlign textAligning;
  final bool isPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters:isPhoneNumber? [
        FilteringTextInputFormatter.deny(
          RegExp(r'^0+'),
        ),

      ]:[

      ],
      textAlign: textAligning,
      enableSuggestions: false,
      autocorrect: false,

      style:  TextStyle(
          fontSize: 15.0,
        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,

        color: kGrayColor,
      ),
      focusNode: focusNode,
      keyboardType: keyboardType,
      cursorColor: kGrayColor,
      obscureText: obsecure,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(right: 10,bottom: -10),
        labelText: labelText,

        isDense: true,
        fillColor: Colors.white,
        filled: true,
        labelStyle:TextStyle(
          fontSize: 15.0,
          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
          color: kGrayColor,
        ),

        prefixIcon:iconOfTextField,
        suffixIcon: icon,
        suffixText: suffixText,
        suffixStyle:  TextStyle(
        fontSize: 15.0,
        fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
        color: kGrayColor,
      ),
        border:  OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color:kLightGrayColor,),
            borderRadius: BorderRadius.circular(10)
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder:   OutlineInputBorder(
          borderSide:  BorderSide(width: 1, color:mainColor,),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide:    BorderSide(color: mainColor,width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onchange,
      controller: controller,
      validator: validator,
      textInputAction: textInputAction,

      autovalidateMode: isAutoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
