import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String loginLink = "${baseUrl}login.php";

  Future<String> login({String userName, String type, String password}) async {
    String message = "";
    Response response;
    response = await Dio().get(
      "$loginLink?type=$type&username=$userName&password=$password",
    );
    if (response.data["status"] == "true") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", response.data["info"]["id"]);
      prefs.setString("name", response.data["info"]["name"]);
      prefs.setString("type", "$type");
      prefs.setString("class", response.data["info"]["class"]);
      message = "done";
    } else {
      message = response.data["msg"];
    }
    return message;
  }
}
