import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:rayanSchool/models/MessageDetailsStudent.dart';
import 'package:rayanSchool/models/MessageSentStudent.dart';
import 'package:rayanSchool/models/message.dart';
import 'package:rayanSchool/models/messageDetails.dart';
import 'package:rayanSchool/models/teachers.dart';

class MessagesService {
  String messages = "${baseUrl}student_msg_income.php";
  String messageDetails = "${baseUrl}student_msg_income_view.php";
  String sendMessageLink = "${baseUrl}student_msg_send.php";
  String sentMessages = "${baseUrl}student_msg_sent.php";
  String sentMessagesDetails = "${baseUrl}student_msg_sent_view.php";
  String teachers = "${baseUrl}teachers_list.php";

  Future<List<Messages>> getMessages({String? id}) async {
    List<Messages> list = [];
    Response response;
    response = await Dio().get(
      "$messages?student_id=$id",
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
      "$sentMessages?student_id=$id",
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
      "$messageDetails?student_id=$id&msg_id=$msgId",
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
      "$sentMessagesDetails?student_id=$id&msg_id=$msgId",
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
      "$sendMessageLink?student_id=$id&sendto_type=$type&teacher_id=$teacherId&title=$title&text=$msg",
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
