import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:rayanSchool/models/MessageDetailsStudent.dart';
import 'package:rayanSchool/models/MessageSentStudent.dart';
import 'package:rayanSchool/models/message.dart';
import 'package:rayanSchool/models/messageDetails.dart';
import 'package:rayanSchool/models/parents/attendance.dart';
import 'package:rayanSchool/models/parents/reportDetails.dart';
import 'package:rayanSchool/models/parents/reports.dart';
import 'package:rayanSchool/models/teachers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/penalties_list_model.dart';
import '../models/recommendation_list_model.dart';

class ParentService {
  String reports = "${baseUrl}parent_report_about.php";
  String reportDetails = "${baseUrl}parent_report_about_view.php";
  String attendance = "${baseUrl}parent_absence.php";
  String messages = "${baseUrl}parent_msg_income.php";
  String messageDetails = "${baseUrl}parent_msg_income_view.php";
  String sendMessageLink = "${baseUrl}parent_msg_send.php";
  String sentMessages = "${baseUrl}parent_msg_sent.php";
  String sentMessagesDetails = "${baseUrl}parent_msg_sent_view.php";
  String teachers = "${baseUrl}teachers_list.php";
  String recommendationList = "${baseUrl}parent_report2.php";
  String penaltiesList = "${baseUrl}parent_attu.php";

  Future<List<Report>> getReports({String? id}) async {
    List<Report> list = [];
    Response response;
    response = await Dio().get(
      "$reports?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Report.fromJson(element));
      });
    }
    return list;
  }

  Future<List<ReportDetails>> getReportDetails(
      {String? id, String? reportId}) async {
    List<ReportDetails> list = [];
    Response response;
    response = await Dio().get(
      "$reportDetails?parent_id=$id&report_id=$reportId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(ReportDetails.fromJson(element));
      });
    }
    return list;
  }
  Future<List<RecommendationListModel>> getRecommendationList(
      {String? typeId, }) async {
    List<RecommendationListModel> list = [];
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");
    response = await Dio().get(
      "$recommendationList?parent_id=$userId&type=$typeId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(RecommendationListModel.fromJson(element));
      });
    }
    return list;
  }
Future<List<PenaltiesListModel>> getPenaltiesList(
       ) async {
    List<PenaltiesListModel> list = [];
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");
    response = await Dio().get(
      "$penaltiesList?parent_id=$userId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(PenaltiesListModel.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Attendance>> getAttendance({String? id}) async {
    List<Attendance> list = [];
    Response response;
    response = await Dio().get(
      "$attendance?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Attendance.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Messages>> getMessages({String? id}) async {
    List<Messages> list = [];
    Response response;
    response = await Dio().get(
      "$messages?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Messages.fromJson(element));
      });
    }
    return list;
  }

  Future<List<MessageSentStudent>> getSentMessages({String? id}) async {
    List<MessageSentStudent> list = [];
    Response response;
    response = await Dio().get(
      "$sentMessages?parent_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(MessageSentStudent.fromJson(element));
      });
    }
    return list;
  }

  Future<List<MessageDetails>> getMessageDetails(
      {String? id, String? msgId}) async {
    List<MessageDetails> list = [];
    Response response;
    response = await Dio().get(
      "$messageDetails?parent_id=$id&msg_id=$msgId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(MessageDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<MessageDetailsStudent>> getSentMessageDetails(
      {String? id, String? msgId}) async {
    List<MessageDetailsStudent> list = [];
    Response response;
    response = await Dio().get(
      "$sentMessagesDetails?parent_id=$id&msg_id=$msgId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(MessageDetailsStudent.fromJson(element));
      });
    }
    return list;
  }

  Future<String> sendMessage(
      {String? id,
      String? teacherId,
      String? msg,
      String? title,
      String? type}) async {
    Response response;
    response = await Dio().post(
      "$sendMessageLink?parent_id=$id&sendto_type=$type&teacher_id=$teacherId&title=$title&text=$msg",
    );
    var data = response.data["status"];
    return data;
  }

  Future<List<Teachers>> getTeacher() async {
    List<Teachers> list = [];
    Response response;
    response = await Dio().post("$teachers");
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Teachers.fromJson(element));
      });
    }
    return list;
  }
}
