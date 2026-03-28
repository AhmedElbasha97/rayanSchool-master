import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization_services.dart';

abstract class StorageKeys {
  // Define all your storage keys as static constants here
  StorageKeys();
  static const String activeLocale = "ACTIVE_LOCAL";
  static const String userId = "User_Id";
  static const String userType = "User_Type";
  static const String userClass = "User_class";
  static const String username = "User_Name";
  static const String notificationRoute = "route";

}

class StorageService extends GetxService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  static Future<StorageService> init() async {
    // await GetStorage.init();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  //to save id of the account
  Future<void> saveAccountId(String userId) async =>
      _prefs.setString(StorageKeys.userId, userId);
  //to save type of the account (student, teacher, parent)
  Future<void> saveAccountType(String userType) async =>
      _prefs.setString(StorageKeys.userType, userType);
  //to save class of the account (1,2,3,4,5,6)
  Future<void> saveAccountClass(String classId) async =>
      _prefs.setString(StorageKeys.userClass, classId);
  //to save name of the account (student, teacher, parent)
  Future<void> saveAccountName(String userName) async =>
      _prefs.setString(StorageKeys.username, userName);
  //to save route of the notification (msg, absence, report, penalty)
  Future<void> saveNotificationRoute(String route) async =>
      _prefs.setString(StorageKeys.notificationRoute, route);
  //to get id of the account
  String get getId {
    return _prefs.getString(StorageKeys.userId)?? "0";
  }
  //to get type of the account (student, teacher, parent)
  String get getUserType {
    return _prefs.getString(StorageKeys.userType)?? "0";
  }
  //to get class of the account (1,2,3,4,5,6)
  String get getUserClass {
    return _prefs.getString(StorageKeys.userClass)?? "0";
  }
  //to get name of the account (student, teacher, parent)
  String get getUserName {
    return _prefs.getString(StorageKeys.username)?? "0";
  }
  //to get route of the notification (msg, absence, report, penalty)
  String get getNotificationRoute {
    return _prefs.getString(StorageKeys.notificationRoute)?? "0";
  }
// to clear all data when user log out

  loggingOut(){
    _prefs.remove(StorageKeys.userId);
  }
// to clear notification route after user click on the notification
  removeNotification(){
    _prefs.remove(StorageKeys.notificationRoute);
  }
  //
  // to check if user record dismissal or not
  bool get checkUserIsSignedIn  {
    return _prefs.containsKey(StorageKeys.userId);
  }
  // to check if there is notification or not
  bool get checkThereIsNotificationOrNot  {
    return _prefs.containsKey(StorageKeys.notificationRoute);
  }




  //Active Locale
  Locale get activeLocale {
    return Locale(_prefs.getString(StorageKeys.activeLocale) ??
        SupportedLocales.arabic.toString());
  }
// to set active locale
  set activeLocale(Locale activeLocal) {
    _prefs.setString(StorageKeys.activeLocale, activeLocal.toString());
  }
}