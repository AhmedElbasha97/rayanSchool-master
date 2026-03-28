
import 'package:rayanSchool/globals/CommonSetting.dart';

import '../Utils/api_service.dart';
import '../Utils/services.dart';

class JoinApplication {
  //send application to the server with the provided details
  //but this call is not used in the app because the application form is sent through web view
  String joinApplication = "${baseUrl}application.php";
  final ApiService api = ApiService();

  Future<String> sendApplication(
      {String? name,
        String? email,
      String? oldSchool,
      String? mobile,
      String? joinSchoolDate,
      String? idNumber,
      String? birthdate,
      String? gender,
      String? religion,
      String? birthPlace,
      String? nationalty,
      String? city,
      String? province,
      String? regNumber,
      String? address,
      String? zipCode,
      String? phone,
      String? year,
      String? regStatus,
      String? parentName,
      String? relation,
      String? parentJob,
      String? notes}) async {

    try {    Map<String, dynamic> param = {
      "exp_fname": "$name",
      "exp_preschool": "$oldSchool",
      "exp_mob": "$mobile",
      "exp_date": "$joinSchoolDate",
      "exp_idstudent": "$idNumber",
      "exp_birthdate": "$birthdate",
      "exp_type": "$gender",
      "exp_religion": "$religion",
      "exp_birthplace": "$birthPlace",
      "exp_nationalty": "$nationalty",
      "exp_provincebrth": "$province",
      "exp_registnum": "$regNumber",
      "exp_address": "$address",
      "exp_city": "$city",
      "exp_zipcode": "$zipCode",
      "exp_tels": "$phone",
      "exp_year": "$year",
      "exp_registstatus": "$regStatus",
      "exp_pname": "$parentName",
      "exp_relation": "$relation",
      "exp_pjob": "$parentJob",
      "exp_notes": "$notes",
      "exp_email": "$email",
    };
      final data = await api.request(
          Services.joinApplication, "GET", queryParameters: param);

      if (data.data["status"] == "true") {
        return data.data["status"];
      } else {
        print("⚠ Unexpected data format: $data");
        return data.data["status"];
      }
    } catch (e) {
      print("❌ sendComplain error: $e");
      return "";
    }

  }
}
