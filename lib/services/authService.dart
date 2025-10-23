import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../Utils/api_service.dart';
import '../Utils/memory.dart';
import '../Utils/services.dart';

class AuthService {
  final ApiService api = ApiService();

  Future<String> login({String? userName, String? type, String? password}) async {


    try {
      dynamic response;
      await FirebaseMessaging.instance.getToken().then((token) async {
         response = await api.request(Services.loginLink,"GET",queryParameters:{
           "type":type,
         "username":userName,
         "password":password,
           "token":token
      });

      });
print(response["status"]);
      if (response.isNotEmpty&&response["status"] == "true") {

        Get.find<StorageService>().saveAccountId(response?["info"]["id"]);
        Get.find<StorageService>().saveAccountType("$type");
        Get.find<StorageService>().saveAccountName(response?["info"]["name"]);
        if(response?["info"]["class"] != null){
        Get.find<StorageService>().saveAccountClass(response?["info"]["class"]);
        }
       return "done";
      } else {
        print("⚠ Unexpected data format: $response");
        return response?["msg"];
      }
    } catch (e) {
      print("❌ login error: $e");
      return "";
    }

  }
  Future<String> changePassword({String? oldPass, String? newPass,}) async {
    try {
      final data = await api.request(
          Services.changePassLink, "GET", queryParameters: {
        "type": Get
            .find<StorageService>()
            .getUserType,
        "user_id": Get
            .find<StorageService>()
            .getId,
        "password_old": oldPass,
        "password": newPass
      });

      if (data["status"] == "true") {
        return "done";
      } else {
        print("⚠ Unexpected data format: $data");
        return data["msg"];
      }
    } catch (e) {
      print("❌ changePassword error: $e");
      return "";
    }
  }
}
