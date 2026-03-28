// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:dio/dio.dart'as call;
import 'package:get/get.dart';
import 'package:rayanSchool/Utils/memory.dart';
import 'package:rayanSchool/models/teacher/HomeWorkDetails.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/homeWork.dart';
import 'package:rayanSchool/models/teacher/messagedetails.dart';
import 'package:rayanSchool/models/teacher/questionBank.dart';
import 'package:rayanSchool/models/teacher/reportDetails.dart';
import 'package:rayanSchool/models/teacher/sentMessages.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import 'package:rayanSchool/models/teacher/teacherReport.dart';

import '../Utils/api_service.dart';
import '../Utils/services.dart';
import '../models/activity_detailed_model.dart';
import '../models/homeWorkDetails.dart';
import '../models/message.dart';
import '../models/messageDetails.dart';
import '../models/teacher/homework_teacher_list_model.dart';

class TeacherService {
  final ApiService api = ApiService();

/// Fetch teacher reports, optionally filtered by teacher ID
  /// [teacherId] - Optional ID to filter reports by specific teacher
  /// but this call is not used in the app
  Future<List<TeacherReport>?> getReports({String? id}) async {
    try {
      final data = await api.request(Services.teacherReports,"GET",queryParameters: {
        "teacher_id":id
      });

      if (data is List) {
        return data
            .map((e) => TeacherReport.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getReports error: $e");
      return [];
    }
  }
  Future<List<Map<String?,String?>>> getRecommendations(String type) async {
    try {
      final response = await api.request(Services.GetRecommendationsURL,"GET",queryParameters: {
        "type":type
      });

      if (response != null) {
        List<Map<String?,String?>> list = [];
        var data = response as Map;
        if (response != null) {
          data.forEach((k,v) {
            list.add({"$k":"$v"});
          });
        }

        return list;
      } else {
        print("⚠ Unexpected data format: $response");
        return [];
      }
    } catch (e) {
      print("❌ getRecommendationList error: $e");
      return [];
    }

  }

  Future<List<TeacherReportDetails>> getReportDetails(
      {String? id, String? reportId}) async {
    try {
      final data = await api.request(Services.teacherReportsDetails,"GET",queryParameters: {
        "teacher_id":id,
        "report_id":reportId
      });

      if (data is List) {
        return data
            .map((e) => TeacherReportDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getReportDetails error: $e");
      return [];
    }

  }
  Future<String> sentRecommendation({String? recommendationType, String? recommendationValue,String? notes,String? studentId}) async {
    try {
      final data = await api.request(
          Services.sendRecommendationsURL, "GET", queryParameters:{
        "type":recommendationType,
        "type_id":recommendationValue,
        "teacher_id":Get.find<StorageService>().getId,
        "student_id":studentId,
        "notes":notes
      });

      if (data["status"] == "true") {
        return "done";
      } else {
        print("⚠ Unexpected data format: $data");
        return data["msg"];
      }
    } catch (e) {
      print("❌ sentRecommendation error: $e");
      return "";
    }


  }
  Future<String> addHomeWork({String? classId, String? title,String? details,File? selectedFile}) async {
    try {
      final formData = call.FormData.fromMap({
        "teacher_id":Get.find<StorageService>().getId,
        "class_id":classId,
        "title":title,
        "p_img":selectedFile?.path.isEmpty??true?null:

        await call.MultipartFile.fromFile(selectedFile?.path??"", filename: selectedFile?.path.split('/').last??""),
        "detail": details,

      });
      final data = await api.request(
          Services.addHomeWorkURL, "POST", data: formData);
      print("data: ${
          data["status"]
      }");
      if ("${data["status"]}" == "true") {
        return "${data["status"]}";
      } else{
          return "failed";
        }

    } catch (e) {
      print("❌ addHomeWork error: $e");
      return "";
    }



  }
  Future<List<HomeworkTeacherListModel>> getTeacherHomeWorksList() async {
    try {
      final data = await api.request(Services.teacherGetHomeWorksURL,"GET",queryParameters: {
        "teacher_id":Get.find<StorageService>().getId,

      });

      if (data is List) {
        return data
            .map((e) => HomeworkTeacherListModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getTeacherHomeWorksList error: $e");
      return [];
    }

  }
  Future<List<HomeWorkDetails>> gethomeWorkTeacherDetails(
      {String? id, String? homeWorkId}) async {
    try {
      final data = await api.request(Services.teacherHomeWorkDetails,"GET",queryParameters: {
        "teacher_id":id,
        "homework_id":homeWorkId
      });

      if (data is List) {
        return data
            .map((e) => HomeWorkDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ gethomeWorkTeacherDetails error: $e");
      return [];
    }

  }
  Future<List<MessageDetails>> getReceivedMessageDetails(
      {String? id, String? msgId}) async {
    try {
      final data = await api.request(Services.teacherMessageDetails,"GET",queryParameters: {
        "teacher_id":id,
        "msg_id":msgId
      });

      if (data is List) {
        return data
            .map((e) => MessageDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getReceivedMessageDetails error: $e");
      return [];
    }

  }
  Future<List<Category>> getCategories() async {
    try {
      final data = await api.request(Services.category,"GET");

      if (data is List) {
        return data
            .map((e) => Category.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getCategories error: $e");
      return [];
    }

  }

  Future<List<Category>> getLevels({String? id}) async {
    try {
      final data = await api.request(Services.category,"GET",queryParameters: {
        "ctg_id":id
      });

      if (data is List) {
        return data
            .map((e) => Category.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getLevels error: $e");
      return [];
    }

  }

  Future<List<Student>> getStudents({String? id}) async {
    try {
      final data = await api.request(Services.studentList,"GET",queryParameters: {
        "class_id":id
      });

      if (data is List) {
        return data
            .map((e) => Student.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getStudents error: $e");
      return [];
    }
  }

  Future<bool> sendReport({String? id, String? studentId, String? msg}) async {
    try {
      DateTime date = DateTime.now();
      String dateString = "${date.year}-${date.month}-${date.day}";
      final data = await api.request(
          Services.sendreports, "GET", queryParameters:{
        "teacher_id":id,"student_id":studentId,"date":dateString,"text":msg
      });

      if (data["status"] == "true") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ sendReport error: $e");
      return false;
    }
  }

  Future<List<HomeWorkTeacher>> getHomeWork({String? id}) async {
    try {
      final data = await api.request(Services.homeWork,"GET",queryParameters: {
        "teacher_id":id,
      });

      if (data is List) {
        return data
            .map((e) => HomeWorkTeacher.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getHomeWork error: $e");
      return [];
    }


  }

  Future<List<SentMessagesTeacher>> getSentMessages({String? id}) async {
    try {
      final data = await api.request(Services.sentMessage,"GET",queryParameters: {"teacher_id":id});

      if (data is List) {
        return data
            .map((e) => SentMessagesTeacher.fromJson(e))
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
  Future<List<Messages>> getReceivedMessages({String? id}) async {
    try {
      final data = await api.request(Services.receivedMessage,"GET",queryParameters: {"teacher_id":id});

      if (data is List) {
        return data
            .map((e) => Messages.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getReceivedMessages error: $e");
      return [];
    }

  }

  Future<String> sendMessages(
      {String? id,
      String? type,
      String? toId,
      String? title,
       String? text}) async {
    try {
      final data = await api.request(
          Services.sendMessage, "GET", queryParameters: {
        "to_id":toId,
        "sendto_type":type,
        "teacher_id":id,
        "title":title,
        "text":text
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

  Future<List<QuestionBankTeacher>> getQuestionBank({required String id}) async {
    try {
      final data = await api.request(Services.teacherQuestionBank,"GET",queryParameters: {"teacher_id":id});

      if (data is List) {
        return data
            .map((e) => QuestionBankTeacher.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getQuestionBank error: $e");
      return [];
    }


  }

  Future<List<HomeWorkDetailsTeacherModel>> getHomeworkDetails(
      {required String id, String? homeworkId}) async {
    try {
      final data = await api.request(Services.homeworkDetails,"GET",queryParameters: {
        "teacher_id":id,
        "homework_id":homeworkId
      });

      if (data is List) {
        return data
            .map((e) => HomeWorkDetailsTeacherModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getHomeworkDetails error: $e");
      return [];
    }
  }

  Future<List<MessageDetailsTeacherModel>> getMessageDetails(
      {required String id, required String msgId}) async {
    try {
      final data = await api.request(Services.sentMessageDetails,"GET",queryParameters: {
        "teacher_id":id,
        "msg_id":msgId
      });

      if (data is List) {
        return data
            .map((e) => MessageDetailsTeacherModel.fromJson(e))
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
  Future<ActivitiesDetailedModel?> getSchedulesTeacher() async {
    try {
      final data = await api.request(Services.getSchedulesTeacherURL,"GET",queryParameters: {"student_id":Get.find<StorageService>().getId,});

      if ( data.isNotEmpty) {
        return ActivitiesDetailedModel.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getSchedulesTeacher error: $e");
      return null;
    }

  }
  Future<List<Category>> getBuildings() async {
    try {
      final data = await api.request(Services.getBuildingsURL,"GET");

      if (data is List) {
        return data
            .map((e) => Category.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getBuildings error: $e");
      return [];
    }

  }
  Future<List<Category>> getNextCategory(String categoryId) async {
    try {
      final data = await api.request(Services.getBuildingsURL,"GET",queryParameters: {
        "ctg_id":categoryId
      });

      if (data is List) {
        return data
            .map((e) => Category.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getNextCategory error: $e");
      return [];
    }

  }
  Future<List<Student>> getStudentIdd(String classId) async {
    try {
      final data = await api.request(Services.getStudentsURL,"GET",queryParameters: {
        "class_id":classId
      });

      if (data is List) {
        return data
            .map((e) => Student.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getStudentIdd error: $e");
      return [];
    }
  }
}
