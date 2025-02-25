import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:rayanSchool/models/AppInfo/News.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/models/AppInfo/newsDetails.dart';
import 'package:rayanSchool/models/AppInfo/sliderPhotos.dart';
import 'package:rayanSchool/models/AppInfo/subject.dart';
import 'package:rayanSchool/models/AppInfo/subjectDetails.dart';

import '../models/school_policies_details_model.dart';
import '../models/school_policies_model.dart';
import '../models/school_social_media_link_model.dart';

class AppInfoService {
  String sliderLink = "${baseUrl}slide.php";
  String aboutSchool = "${baseUrl}about.php";
  String schoolPolicyUrl = "${baseUrl}privacy2.php";
  String schoolWord = "${baseUrl}school_desc.php";
  String aboutApp = "${baseUrl}about_app.php";
  String privacyPolicy = "${baseUrl}privacy.php";
  String schoolSocialMediaLink = "${baseUrl}social_links.php";
  String subjects = "${baseUrl}subjects.php";
  String subjectsDetails = "${baseUrl}art.php";
  String schoolPoliciesDetails = "${baseUrl}articles_view.php";
  String news = "${baseUrl}news.php";
  String newsDetails = "${baseUrl}news_view.php";

  Future<List<SliderData>> getSliderPhotos() async {
    List<SliderData> list = [];
    Response response;
    print(sliderLink);
    response = await Dio().get(
      "$sliderLink",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(SliderData.fromJson(element));
    });
    return list;
  }

  Future<AboutSchool> getAboutSchool() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      "$aboutSchool",
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }
  Future<AboutSchool> getSchoolPolicy() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      "$schoolPolicyUrl",
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<AboutSchool> getSchoolWord() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      "$schoolWord",
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<AboutSchool> getaboutApp() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      "$aboutApp",
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }

  Future<AboutSchool> getPrivacyPolicy() async {
    AboutSchool data;
    Response response;
    response = await Dio().get(
      "$privacyPolicy",
    );
    var resData = response.data;
    data = AboutSchool.fromJson(resData[0]);
    return data;
  }
  Future<SchoolSocialMediaLinkModel> getSchoolSocialMediaLink() async {
    SchoolSocialMediaLinkModel data;
    Response response;
    print("$schoolSocialMediaLink",);
    response = await Dio().get(
      "$schoolSocialMediaLink",
    );
    var resData = response.data;
    data = SchoolSocialMediaLinkModel.fromJson(resData);
    return data;
  }

  Future<List<Subjects>?> getSubjects() async {
    List<Subjects> list = [];
    Response response;
    response = await Dio().get(
      "$subjects",
    );
    print("$subjects");
    var data = response.data;
    if(data !=null) {

    data.forEach((element) {
      list.add(Subjects.fromJson(element));
    });
  }
    return list;
  }
  Future<List<SchoolPoliciesModel>?> getSchoolPolicies() async {
    List<SchoolPoliciesModel> list = [];
    Response response;
    response = await Dio().get(
      "https://alrayyanprivateschools.com/api/articles.php?id=762",
    );
    print("https://alrayyanprivateschools.com/api/articles.php?id=762",);
    var data = response.data;
    if(data !=null) {

    data.forEach((element) {
      list.add(SchoolPoliciesModel.fromJson(element));
    });
  }
    return list;
  }

  Future<List<SubjectDetails>> getSubjectDetails({String? id}) async {
    List<SubjectDetails> list = [];
    Response response;
    response = await Dio().get(
      "$subjectsDetails?dep_id=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(SubjectDetails.fromJson(element));
    });
    return list;
  }
  Future<List<SchoolPoliciesDetailsModel>> getSchoolPoliciesDetails({String? id}) async {
    List<SchoolPoliciesDetailsModel> list = [];
    Response response;
    response = await Dio().get(
      "$schoolPoliciesDetails?arts_id=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(SchoolPoliciesDetailsModel.fromJson(element));
    });
    return list;
  }

  Future<List<News>?> getNews() async {
    List<News> list = [];
    Response response;
    response = await Dio().get(
      "$news",
    );
    print("$news");

    var data = response.data;
    if(data !=null) {
      data.forEach((element) {
        list.add(News.fromJson(element));
      });
      return list;
    }
  }

  Future<List<NewsDetails>> getNewsDetails({String? id}) async {
    List<NewsDetails> list = [];
    Response response;
    response = await Dio().get(
      "$newsDetails?news_id=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(NewsDetails.fromJson(element));
    });
    return list;
  }
}
