
// ignore_for_file: unnecessary_null_comparison

import 'package:get/get.dart';
import 'package:rayanSchool/Utils/translation_key.dart';

class ValidatorHelper {
  ValidatorHelper._privateConstructor();

  static final ValidatorHelper instance = ValidatorHelper._privateConstructor();
// Validate name field using the validateEmptyField method
  String? validateName(String? name) => validateEmptyField(name);
// Validate email field using the validateEmail method
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

// Validate phone number field using the validatePhoneNumberField method
  String? validateEmptyField(String? firName) {
    if (firName == null) {
      return requiredFiled.tr;
    } else if (firName.isEmpty) {
      return requiredFiled.tr;
    } else {
      return null;
    }
  }
// Validate phone number field using the validatePhoneNumberField method
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


// Validate password field using the validatePassword method
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

// Helper method to check if the password is not valid based on the defined criteria

  bool isPasswordNotValid(String password) {
    return !RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }
// Helper method to check if the email is not valid based on the defined regex pattern
  bool isEmailNotValid(String email) {
    return !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
// Helper method to check if the phone number is not valid based on the defined regex pattern
  bool isPhoneNotValid(String phone) {
    return !RegExp(
        r'(^(?:[+0]9)?[0-9]{8}$)')
        .hasMatch(email);
  }
}
