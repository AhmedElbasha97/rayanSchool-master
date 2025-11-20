import 'package:get/get.dart';
import 'package:rayanSchool/models/MessageDetailsStudent.dart';
import 'package:rayanSchool/models/MessageSentStudent.dart';
import 'package:rayanSchool/models/message.dart';
import 'package:rayanSchool/models/messageDetails.dart';
import 'package:rayanSchool/models/teachers.dart';

import '../Utils/api_service.dart';
import '../Utils/memory.dart';
import '../Utils/services.dart';
import '../models/message_title_list_model.dart';

class MessagesService {
  final ApiService api = ApiService();


  Future<List<Messages>> getMessages({String? id}) async {
    try {
      final data = await api.request(Services.messages,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => Messages.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getMessages error: $e");
      return [];
    }
  }

  Future<List<MessageSentStudent>> getSentMessages({String? id}) async {
    try {
      final data = await api.request(Services.sentMessages,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => MessageSentStudent.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getSentMessages error: $e");
      return [];
    }

  }

  Future<List<MessageDetails>> getMessageDetails(
      {String? id, String? msgId}) async {
    try {
      final data = await api.request(Services.messageDetails,"GET",queryParameters: {"student_id":id,"msg_id":msgId});

      if (data is List) {
        return data
            .map((e) => MessageDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getMessageDetails error: $e");
      return [];
    }
  }

  Future<List<MessageDetailsStudent>> getSentMessageDetails(
      {String? id, String? msgId}) async {
    try {
      final data = await api.request(Services.sentMessagesDetails,"GET",queryParameters: {"student_id":id,"msg_id":msgId});

      if (data is List) {
        return data
            .map((e) => MessageDetailsStudent.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getSentMessageDetails error: $e");
      return [];
    }

  }

  Future<String> sendMessage(
      {String? id,
      String? teacherId,
      String? msg,
      String? title,
      String? type}) async {
    try {
      final data = await api.request(
          Services.sendMessageLink, "POST", queryParameters: {
        "student_id":id,"sendto_type":type,"teacher_id":teacherId,"title":title,"text":msg
      });

      if (data["status"] == "true") {
        return data["status"];
      } else {
        print("⚠ Unexpected data format: $data");
        return data["msg"];
      }
    } catch (e) {
      print("❌ sendMessage error: $e");
      return "";
    }

  }

  Future<List<Teachers>> getTeacher() async {
    try {

      final data = await api.request(Services.teachers,"GET",queryParameters: {"exp_id": Get
          .find<StorageService>()
          .getId});

      if (data is List) {
        return data
            .map((e) => Teachers.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getTeacher error: $e");
      return [];
    }


  }
  Future<List<MessageTitleModel>> getMessageTitles() async {
    try {
      final data = await api.request(Services.messageTitleList,"GET");

      if (data is List) {
        return data
            .map((e) => MessageTitleModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getTeacher error: $e");
      return [];
    }


  }
}
