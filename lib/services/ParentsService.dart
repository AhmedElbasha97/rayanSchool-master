import 'package:get/get.dart';
import 'package:rayanSchool/models/MessageDetailsStudent.dart';
import 'package:rayanSchool/models/MessageSentStudent.dart';
import 'package:rayanSchool/models/message.dart';
import 'package:rayanSchool/models/messageDetails.dart';
import 'package:rayanSchool/models/parents/attendance.dart';
import 'package:rayanSchool/models/parents/reportDetails.dart';
import 'package:rayanSchool/models/parents/reports.dart';
import 'package:rayanSchool/models/teachers.dart';
import '../Utils/api_service.dart';
import '../Utils/memory.dart';
import '../Utils/services.dart';
import '../models/parents/child_model.dart';
import '../models/penalties_list_model.dart';
import '../models/recommendation_list_model.dart';

class ParentService {
  final ApiService api = ApiService();


  Future<List<Report>> getReports({String? id}) async {
    try {
      final data = await api.request(Services.reports,"GET",queryParameters: {
        "parent_id":id
      });

      if (data is List) {
        return data
            .map((e) => Report.fromJson(e))
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

  Future<List<ReportDetails>> getReportDetails(
      {String? id, String? reportId}) async {
    try {
      final data = await api.request(Services.reportDetails,"GET",queryParameters: {
        "parent_id":id,
        "report_id":reportId
      });

      if (data is List) {
        return data
            .map((e) => ReportDetails.fromJson(e))
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
  Future<List<RecommendationListModel>> getRecommendationList(
      {String? typeId, }) async {
    try {
      final data = await api.request(Services.recommendationList,"GET",queryParameters: {
        "parent_id":Get
            .find<StorageService>()
            .getId,
        "type":typeId
      });

      if (data is List) {
        return data
            .map((e) => RecommendationListModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getRecommendationList error: $e");
      return [];
    }

  }
Future<List<PenaltiesListModel>> getPenaltiesList(
       ) async {
  try {
    final data = await api.request(Services.penaltiesList,"GET",queryParameters: {
      "parent_id":Get
          .find<StorageService>()
          .getId,

    });

    if (data is List) {
      return data
          .map((e) => PenaltiesListModel.fromJson(e))
          .toList();
    } else {
      print("⚠ Unexpected data format: $data");
      return [];
    }
  } catch (e) {
    print("❌ getPenaltiesList error: $e");
    return [];
  }

  }

  Future<List<Attendance>> getAttendance({String? id}) async {
    try {
      final data = await api.request(Services.attendance,"GET",queryParameters: {
        "parent_id":Get
            .find<StorageService>()
            .getId,

      });

      if (data is List) {
        return data
            .map((e) => Attendance.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getAttendance error: $e");
      return [];
    }
  }

  Future<List<Messages>> getMessages({String? id}) async {
    try {
      final data = await api.request(Services.parentMessages,"GET",queryParameters: {
        "parent_id":id,

      });

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
      final data = await api.request(Services.parentSentMessages,"GET",queryParameters: {
        "parent_id":id,

      });

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
      final data = await api.request(Services.parentMessageDetails,"GET",queryParameters: {
        "parent_id":id,
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
      print("❌ getSentMessages error: $e");
      return [];
    }

  }
  Future<List<ChildModel>> getChildList() async {
    try {
      final data = await api.request(Services.childList,"GET",queryParameters: {
        "parent_id":Get
            .find<StorageService>()
            .getId,

      });

      if (data is List) {
        return data
            .map((e) => ChildModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getChildList error: $e");
      return [];
    }

  }

  Future<List<MessageDetailsStudent>> getSentMessageDetails(
      {String? id, String? msgId}) async {
    try {
      final data = await api.request(Services.parentSentMessagesDetails,"GET",queryParameters: {
        "parent_id":id,
        "msg_id":msgId
      });

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
      String? msg,
      String? title,
      String? type}) async {
    try {
      final data = await api.request(
          Services.parentSendMessageLink, "POST", queryParameters: {
       "sendto_type":type, "parent_id":id,"title":title,"text":msg
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
      final data = await api.request(Services.teachers, "POST");

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
}
