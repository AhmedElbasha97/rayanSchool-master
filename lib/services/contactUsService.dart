import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';

class ContactUsService {
  String complainsUrl = "${baseUrl}claim.php";
  String sendUs = "${baseUrl}contact.php";

  sendComplain(String name, String message, String email, String subject,
      String mobile) async {
    Response response;
    response = await Dio().post(
      "$complainsUrl?name=$name&email=$email&subject=$subject&messege=$message&mobile=$mobile",
    );
    var data = response.data["status"];
    return data;
  }

  contactUs(String name, String message, String email, String subject,
      String mobile) async {
    Response response;
    response = await Dio().post(
      "$sendUs?name=$name&email=$email&subject=$subject&messege=$message&mobile=$mobile",
    );
    var resData = response.data;
    print(resData);
  }
}
