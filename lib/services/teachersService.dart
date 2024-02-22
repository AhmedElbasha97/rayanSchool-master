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

  Future<List<TeacherReport>> getReports({String id}) async {
    List<TeacherReport> list = [];
    Response response;
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

  Future<List<TeacherReportDetails>> getReportDetails(
      {String id, String reportId}) async {
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

  Future<List<Category>> getLevels({String id}) async {
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

  Future<List<Student>> getStudents({String id}) async {
    List<Student> list = [];
    Response response;
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

  Future<bool> sendReport({String id, String studentId, String msg}) async {
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

  Future<List<HomeWorkTeacher>> getHomeWork({String id}) async {
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

  Future<List<SentMessagesTeacher>> getSentMessages({String id}) async {
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
      {String id,
      String type,
      String toId,
      String title,
      String body,
      String text}) async {
    Response response;
    response = await Dio().get(
      "$sendMessage?teacher_id=$id&sendto_type=$type&to_id=$toId&title=$title&text=$text",
    );
    var data = response.data["status"];

    return data;
  }

  Future<List<QuestionBankTeacher>> getQuestionBank({String id}) async {
    List<QuestionBankTeacher> list = [];
    Response response;
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
      {String id, String homeworkId}) async {
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

  Future<List<MessageDetailsTeacherModel>> getsentMessageDetails(
      {String id, String msgId}) async {
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

}
