import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';

class JoinApplication {
  String joinApplication = "${baseUrl}application.php";

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
    Map<String, dynamic> param = {
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

    // param.removeWhere(
    //     (key, value) => (value == "" || value.isEmpty || value == null));
    Dio dio = Dio();

    Response response;
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: true,
    ));
    response = await dio.post("$joinApplication",queryParameters: param);
   print("$joinApplication?exp_fname:$name&exp_preschool:$oldSchool&exp_mob:$mobile &exp_date:$joinSchoolDate &exp_idstudent:$idNumber&exp_birthdate:$birthdate &exp_type: $gender &exp_religion: $religion &exp_birthplace: $birthPlace &exp_nationalty:$nationalty&exp_provincebrth:$province&exp_registnum:$regNumber&exp_address: $address&exp_city: $city&exp_zipcode: $zipCode&exp_tels: $phone&exp_year: $year&exp_registstatus:$regStatus&exp_pname:$parentName&exp_relation:$relation&exp_pjob:$parentJob&exp_notes:$notes&exp_email:$email");
    var data = response.data["status"];
    return data;
  }
}
