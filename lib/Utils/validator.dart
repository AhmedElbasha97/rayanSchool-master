
// ignore_for_file: unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:rayanSchool/Utils/translation_key.dart';

class ValidatorHelper {
  ValidatorHelper._privateConstructor();

  static final ValidatorHelper instance = ValidatorHelper._privateConstructor();

  String? validateName(String? name) => validateEmptyField(name);

  String? validateEmail(String? email) {
    if (email != null) {
      if (email.isNotEmpty) {
        final notValid = isEmailNotValid(email);
        if (notValid) {
          return invalidEmail.tr;
        }
      }else{
       return requiredFiled.tr;
      }
    }else{
      return requiredFiled.tr;
    }
    return null;
  }


  String? validateEmptyField(String? firName) {
    if (firName == null) {
      return requiredFiled.tr;
    } else if (firName.isEmpty) {
      return requiredFiled.tr;
    } else {
      return null;
    }
  }

  String? validatePhoneNumberField(String? phone) {
    final notValid = phone!.isAlphabetOnly;
    if (phone == null) {
      return phoneNumberError.tr;
    } else if (phone.isEmpty) {
      return phoneNumberError.tr;
    } else if(notValid){
      return phoneNumberError.tr;
    }else{
      return null;
    }
  }



  String? validatePassword(String? password) {
    if (password != null) {
      if (password.isNotEmpty) {
        final notValid = isPasswordNotValid(password);
        if (notValid) {
          return invalidPassword.tr;
        }
      }else{
          return requiredFiled.tr;
        }
      }else{
        return requiredFiled.tr;
      }
    return null;
  }



  bool isPasswordNotValid(String password) {
    return !RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }

  bool isEmailNotValid(String email) {
    return !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  bool isPhoneNotValid(String email) {
    return !RegExp(
        r'(^(?:[+0]9)?[0-9]{8}$)')
        .hasMatch(email);
  }
}
