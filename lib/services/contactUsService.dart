
import '../Utils/api_service.dart';
import '../Utils/services.dart';

class ContactUsService {

  final ApiService api = ApiService();

  sendComplain(String name, String message, String email, String subject,
      String mobile) async {
    try {
    final data = await api.request(
        Services.complainsUrl, "POST", queryParameters: {
      "name":name,"email":email,"subject":subject,"messege":message,"mobile":mobile
    });

    if (data["status"] == "true") {
      return data["status"];
    } else {
      print("⚠ Unexpected data format: $data");
      return data["status"];
    }
  } catch (e) {
    print("❌ sendComplain error: $e");
    return "";
  }
  }



  contactUs(String name, String message, String email, String subject,
      String mobile) async {
    try {
      final data = await api.request(
          Services.sendUs, "POST", queryParameters: {
        "name":name,"email":email,"subject":subject,"messege":message,"mobile":mobile
      });

      if (data.data.isBlank) {
        return data.data;
      } else {
        print("⚠ Unexpected data format: $data");
        return data.data;
      }
    } catch (e) {
      print("❌ sendComplain error: $e");
      return "";
    }

  }
}
