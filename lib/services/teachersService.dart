import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:rayanSchool/models/teacher/HomeWorkDetails.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/homeWork.dart';
import 'package:rayanSchool/models/teacher/messagedetails.dart';
import 'package:rayanSchool/models/teacher/questionBank.dart';
import 'package:rayanSchool/models/teacher/reportDetails.dart';
import 'package:rayanSchool/models/teacher/sentMessages.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import 'package:rayanSchool/models/teacher/teacherReport.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/activity_detailed_model.dart';
import '../models/teacher/homework_teacher_list_model.dart';

class TeacherService {
  String reports = "${baseUrl}teacher_reports.php";
  String reportsDetails = "${baseUrl}teacher_report_view.php";
  String sendreports = "${baseUrl}teacher_report_add.php";
  String category = "${baseUrl}categories_list.php";
  String studentList = "${baseUrl}student_list.php";
  String homeWork = "${baseUrl}teacher_homework.php";
  String sentMessage = "${baseUrl}teacher_msg_sent.php";
  String sendMessage = "${baseUrl}teacher_msg_send.php";
  String questionBank = "${baseUrl}teacher_quest_bank.php";
  String homeworkDetails = "${baseUrl}teacher_homework_view.php";
  String sentMessageDetails = "${baseUrl}teacher_msg_sent_view.php";
  String GetRecommendationsURL = "${baseUrl}report2_list.php";
  String sendRecommendationsURL = "${baseUrl}teacher_reports2.php";
  String addHomeWorkURL = "${baseUrl}teacher_homework_add.php";
  String getHomeWorksURL = "${baseUrl}teacher_homework.php";
  String getSchedulesTeacherURL = "${baseUrl}teacher_table.php";

  Future<List<TeacherReport>> getReports({String? id}) async {
    List<TeacherReport> list = [];
    Response response;
    print("$reports?teacher_id=$id");
    response = await Dio().get(
      "$reports?teacher_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(TeacherReport.fromJson(element));
      });
    }
    return list;
  }
  Future<List<Map<String?,String?>>> getRecommendations(String type) async {
    List<Map<String?,String?>> list = [];
    Response response;
    response = await Dio().get(
      "$GetRecommendationsURL?type=$type",
    );
    var data = response.data as Map;
    print(data);
    if (response.data != null) {
      data.forEach((k,v) {
        list.add({"$k":"$v"});
      });
    }
    return list;
  }

  Future<List<TeacherReportDetails>> getReportDetails(
      {String? id, String? reportId}) async {
    List<TeacherReportDetails> list = [];
    Response response;
    response = await Dio().get(
      "$reportsDetails?teacher_id=$id&report_id=$reportId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(TeacherReportDetails.fromJson(element));
      });
    }
    return list;
  }
  Future<String> sentRecommendation({String? recommendationType, String? recommendationValue,String? notes,String? studentId}) async {
    String message = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");
    Response? response;
    print("$sendRecommendationsURL?type=$recommendationType&type_id=$recommendationValue&teacher_id=$userId&student_id=$studentId&notes=$notes");
    response = await Dio().get(
      "$sendRecommendationsURL?type=$recommendationType&type_id=$recommendationValue&teacher_id=$userId&student_id=$studentId&notes=$notes",
    );


    if (response.data["status"] == "true") {

      message = "done";
    } else {
      message = response.data["msg"];
    }
    return message;
  }
  Future<String> addHomeWork({String? classId, String? title,String? details}) async {
    String message = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");
    print("$addHomeWorkURL?teacher_id=$userId&class_id=$classId&title=$title&detail=$details");
    var dio =Dio();
    dio.options.connectTimeout = const Duration(milliseconds: 800000) ;
    dio.options.receiveTimeout =  const Duration(milliseconds: 800000) ;
    Response? response = await dio.get(
      "$addHomeWorkURL?teacher_id$userId&class_id$classId&title=$title&detail=$details",
    );
    print(response.statusCode.toString());
    if(response.data != null) {
      if (response.data["status"] == "true") {
        message = "done";
      } else {
        message = response.data["msg"];
      }
    }else{
      if(response.statusCode == 200){
        message = "done";
      }else{
        message = "failed";
      }
    }
    return message;
  }
  Future<List<HomeworkTeacherListModel>> getTeacherHomeWorksList() async {
    List<HomeworkTeacherListModel> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = await prefs.getString("id");
    Response response;
    response = await Dio().get(
      "$getHomeWorksURL?teacher_id=$userId",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(HomeworkTeacherListModel.fromJson(element));
    });
    return list;
  }
  Future<List<Category>> getCategories() async {
    List<Category> list = [];
    Response response;
    response = await Dio().get(
      "$category",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Category.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Category>> getLevels({String? id}) async {
    List<Category> list = [];
    Response response;
    response = await Dio().get(
      "$category?ctg_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Category.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Student>> getStudents({String? id}) async {
    List<Student> list = [];
    Response response;
    print("$studentList?class_id=$id");
    response = await Dio().get(
      "$studentList?class_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Student.fromJson(element));
      });
    }
    return list;
  }

  Future<bool> sendReport({String? id, String? studentId, String? msg}) async {
    DateTime date = DateTime.now();
    String dateString = "${date.year}-${date.month}-${date.day}";
    Response response;
    response = await Dio().get(
      "$sendreports?teacher_id=$id&student_id=$studentId&date=$dateString&text=$msg",
    );
    var data = response.data;
    if (data["status"] == "true") {
      return true;
    } else {
      return false;
    }
  }

  Future<List<HomeWorkTeacher>> getHomeWork({String? id}) async {
    List<HomeWorkTeacher> list = [];
    Response response;
    response = await Dio().get(
      "$homeWork?teacher_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(HomeWorkTeacher.fromJson(element));
      });
    }
    return list;
  }

  Future<List<SentMessagesTeacher>> getSentMessages({String? id}) async {
    List<SentMessagesTeacher> list = [];
    Response response;
    response = await Dio().get(
      "$sentMessage?teacher_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(SentMessagesTeacher.fromJson(element));
      });
    }
    return list;
  }

  Future<String> sendMessages(
      {String? id,
      String? type,
      String? toId,
      String? title,
      String? body,
       String? text}) async {
    Response response;
    response = await Dio().get(
      "$sendMessage?teacher_id=$id&sendto_type=$type&to_id=$toId&title=$title&text=$text",
    );
    var data = response.data["status"];

    return data;
  }

  Future<List<QuestionBankTeacher>> getQuestionBank({required String id}) async {
    List<QuestionBankTeacher> list = [];
    Response response;
    print("$questionBank?teacher_id=$id");
    response = await Dio().get(
      "$questionBank?teacher_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(QuestionBankTeacher.fromJson(element));
      });
    }
    return list;
  }

  Future<List<HomeWorkDetailsTeacherModel>> getHomeworkDetails(
      {required String id, String? homeworkId}) async {
    List<HomeWorkDetailsTeacherModel> list = [];
    Response response;
    response = await Dio()
        .get("$homeworkDetails??teacher_id=$id&homework_id=$homeworkId");
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(HomeWorkDetailsTeacherModel.fromJson(element));
      });
    }
    return list;
  }

  Future<List<MessageDetailsTeacherModel>> getMessageDetails(
      {required String id, required String msgId}) async {
    List<MessageDetailsTeacherModel> list = [];
    Response response;
    response =
        await Dio().get("$sentMessageDetails??teacher_id=$id&msg_id=$msgId");
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(MessageDetailsTeacherModel.fromJson(element));
      });
    }
    return list;
  }
  Future<ActivitiesDetailedModel> getSchedulesTeacher() async {
    ActivitiesDetailedModel data;
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");
    response = await Dio().get(
      "$getSchedulesTeacherURL?student_id=$userId",
    );
    var resData = response.data;
    data = ActivitiesDetailedModel.fromJson(resData[0]);
    return data;
  }
}
