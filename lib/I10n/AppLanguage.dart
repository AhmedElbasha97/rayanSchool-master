import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  // Set the default locale to Arabic
  Locale _appLocale = Locale('ar');

  Locale get appLocal => _appLocale;
// Fetch the saved locale from shared preferences, or default to Arabic if not set
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('ar');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code')??"");
    return Null;
  }
// Change the app's locale and save the selection in shared preferences
  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
