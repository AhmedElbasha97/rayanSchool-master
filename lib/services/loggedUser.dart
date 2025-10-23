import 'package:rayanSchool/models/FilesDetails.dart';
import 'package:rayanSchool/models/Student/AskedQuestion.dart';
import 'package:rayanSchool/models/Student/AskedQuestionDetails.dart';
import 'package:rayanSchool/models/Student/book.dart';
import 'package:rayanSchool/models/files.dart';
import 'package:rayanSchool/models/homeWork.dart';
import 'package:rayanSchool/models/homeWorkDetails.dart';
import 'package:rayanSchool/models/importantFiles.dart';
import 'package:rayanSchool/models/question.dart';
import 'package:rayanSchool/models/questionDetails.dart';

import '../Utils/api_service.dart';
import '../Utils/services.dart';
import '../models/Student/schadules_student_model.dart';
import '../models/activity_detailed_model.dart';
import '../models/activity_list_model.dart';

class LoggedUser {

  final ApiService api = ApiService();

  Future<List<Files>?> getFiles({String? id}) async {
    try {
    final data = await api.request(Services.filesLink,"GET",queryParameters: {"student_id":id});

    if (data is List) {
      return data
          .map((e) => Files.fromJson(e))
          .toList();
    } else {
      print("⚠ Unexpected data format: $data");
      return [];
    }
  } catch (e) {
    print("❌ getFiles error: $e");
    return [];
  }

  }

  Future<List<ImportantFile>> getImportantFiles({String? id}) async {
    try {
      final data = await api.request(Services.importantFile,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => ImportantFile.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getImportantFiles error: $e");
      return [];
    }

  }

  Future<List<FileDetails>> getFilesDetails({String? id, String? fileID}) async {
    try {
      final data = await api.request(Services.fileDetails,"GET",queryParameters: {"student_id":id,"file_id":fileID});

      if (data is List) {
        return data
            .map((e) => FileDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getFilesDetails error: $e");
      return [];
    }

  }

  Future<List<HomeWork>> getHomeWorks({String? id}) async {
    try {
      final data = await api.request(Services.homeWorks,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => HomeWork.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getHomeWorks error: $e");
      return [];
    }

  }

  Future<List<HomeWorkDetails>> gethomeWorkDetails(
      {String? id, String? homeWorkId}) async {
    try {
      final data = await api.request(Services.homeWorkDetails,"GET",queryParameters: {"student_id":id,"homework_id":homeWorkId});

      if (data is List) {
        return data
            .map((e) => HomeWorkDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ gethomeWorkDetails error: $e");
      return [];
    }

  }

  Future<List<Question>?> getQuestions({String? id}) async {
    try {
      final data = await api.request(Services.questionBank,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => Question.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getQuestions error: $e");
      return [];
    }

  }

  Future<List<QuestionDetails>> getQuestionsDetails(
      {String? id, String? qId}) async {
    try {
      final data = await api.request(Services.questionDetails,"GET",queryParameters: {"student_id":id,"file_id":qId});

      if (data is List) {
        return data
            .map((e) => QuestionDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getQuestionsDetails error: $e");
      return [];
    }
  }

  Future<List<Books>?> getBooks({String? id}) async {
    try {
      final data = await api.request(Services.books,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => Books.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getBooks error: $e");
      return [];
    }

  }

  Future<List<AskedQuestion>?> getAskedQuestions({String? id}) async {
    try {
      final data = await api.request(Services.askedQuestions,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => AskedQuestion.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getAskedQuestions error: $e");
      return [];
    }

  }

  Future<List<AskedQuestionDetails>> getAskedQuestionsDetails(
      {String? id, String? qid}) async {
    try {
      final data = await api.request(Services.askedQuestionsDetails,"GET",queryParameters: {"student_id":id,"msg_id":qid});

      if (data is List) {
        return data
            .map((e) => AskedQuestionDetails.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getAskedQuestionsDetails error: $e");
      return [];
    }


  }
  Future<List<ActivitiesListModel>> getStudentHomeWorksList(String? id) async {
    try {
      final data = await api.request(Services.getHomeWorksURL,"GET",queryParameters: {"student_id":id});

      if (data is List) {
        return data
            .map((e) => ActivitiesListModel.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getStudentHomeWorksList error: $e");
      return [];
    }

  }
  Future<ActivitiesDetailedModel?> getHomeWorkDetails(String? id ,String homeWorkId) async {
    try {
      final data = await api.request(Services.getHomeWorkDetailURL,"GET",queryParameters: {"student_id":id,"homework_id":homeWorkId});

      if ( data.isNotEmpty) {
        return ActivitiesDetailedModel.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getHomeWorkDetails error: $e");
      return null;
    }

  }
  Future<SchadulesStudentModel?> getSchadules(String? id) async {
    try {
      final data = await api.request(Services.getSchadulesURL,"GET",queryParameters: {"student_id":id,});

      if ( data.isNotEmpty) {
        return SchadulesStudentModel.fromJson(data[0]);
      } else {
        print("⚠ Unexpected data format: $data");
        return null;
      }
    } catch (e) {
      print("❌ getSchadules error: $e");
      return null;
    }

  }
}
