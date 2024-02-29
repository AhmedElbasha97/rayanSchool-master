import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String loginLink = "${baseUrl}login.php";

  Future<String> login({String? userName, String? type, String? password}) async {
    String message = "";
    Response? response;
    await FirebaseMessaging.instance.getToken().then((token) async {
      print("$loginLink?type=$type&username=$userName&password=$password&token=$token");
      response = await Dio().get(
        "$loginLink?type=$type&username=$userName&password=$password&token=$token",
      );
    });

    if (response?.data["status"] == "true") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", response?.data["info"]["id"]);
      prefs.setString("name", response?.data["info"]["name"]);
      prefs.setString("type", "$type");
      if(response?.data["info"]["class"] != null){
        prefs.setString("class", response?.data["info"]["class"]);
      }

      message = "done";
    } else {
      message = response?.data["msg"];
    }
    return message;
  }
}
