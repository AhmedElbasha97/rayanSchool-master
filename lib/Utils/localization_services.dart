import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'memory.dart';


class SupportedLocales {
  // List of all supported locales in the app
  static List<Locale> all = [const Locale("en"), const Locale("ar")];

  static Locale english = const Locale("en");
  static Locale arabic = const Locale("ar");
}

class LocalizationService extends GetxService {
  // Constructor that takes the active locale as a parameter
  LocalizationService(this._activeLocale);

  final Locale _activeLocale;

  Locale get activeLocale => _activeLocale;
// Static method to initialize the LocalizationService and set the active locale from storage
  static LocalizationService init() {
    //Get active local from storage
    Locale activeLocale = Get.find<StorageService>().activeLocale;
    return LocalizationService(activeLocale);
  }
// Method to toggle between English and Arabic locales
  void toggleLocale() {
    final Locale newLocale =
    Get.find<StorageService>().activeLocale == SupportedLocales.arabic
        ? SupportedLocales.english
        : SupportedLocales.arabic;
    //in storage
    Get.find<StorageService>().activeLocale = newLocale;

    //in Getx
    Get.updateLocale(newLocale);
  }
}