import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Student/schadules_student_model.dart';
import '../models/activity_detailed_model.dart';
import '../models/activity_list_model.dart';

class LoggedUser {
  String filesLink = "${baseUrl}student_download_files.php";
  String fileDetails = "${baseUrl}student_download_files_view.php";
  String homeWorks = "${baseUrl}student_homework.php";
  String homeWorkDetails = "${baseUrl}student_homework_view.php";
  String questionBank = "${baseUrl}student_quest_bank.php";
  String questionDetails = "${baseUrl}student_quest_bank_view.php";
  String importantFile = "${baseUrl}student_prog.php";
  String books = "${baseUrl}student_books.php";
  String askedQuestions = "${baseUrl}student_ask_income.php";
  String askedQuestionsDetails = "${baseUrl}student_ask_income_view.php";
  String getHomeWorksURL = "${baseUrl}student_homework.php";
  String getHomeWorkDetailURL = "${baseUrl}student_homework_view.php";
  String getSchadulesURL = "${baseUrl}student_table.php";

  Future<List<Files>?> getFiles({String? id}) async {
    List<Files> list = [];
    Response response;
    response = await Dio().get(
      "$filesLink?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Files.fromJson(element));
      });
    }
    return list;
  }

  Future<List<ImportantFile>> getImportantFiles({String? id}) async {
    List<ImportantFile> list = [];
    Response response;
    response = await Dio().get(
      "$importantFile?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(ImportantFile.fromJson(element));
      });
    }
    return list;
  }

  Future<List<FileDetails>> getFilesDetails({String? id, String? fileID}) async {
    List<FileDetails> list = [];
    Response response;
    response = await Dio().get(
      "$fileDetails?student_id=$id&file_id=$fileID",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(FileDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<HomeWork>> getHomeWorks({String? id}) async {
    List<HomeWork> list = [];
    Response response;
    response = await Dio().get(
      "$homeWorks?student_id=$id",
    );
    if (response.data != null) {
      var data = response.data;
      data.forEach((element) {
        list.add(HomeWork.fromJson(element));
      });
    }
    return list;
  }

  Future<List<HomeWorkDetails>> gethomeWorkDetails(
      {String? id, String? homeWorkId}) async {
    List<HomeWorkDetails> list = [];
    Response response;
    response = await Dio().get(
      "$homeWorkDetails?student_id=$id&homework_id=$homeWorkId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(HomeWorkDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Question>?> getQuestions({String? id}) async {
    List<Question> list = [];
    Response response;
    response = await Dio().get(
      "$questionBank?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Question.fromJson(element));
      });
    }
    return list;
  }

  Future<List<QuestionDetails>> getQuestionsDetails(
      {String? id, String? qId}) async {
    List<QuestionDetails> list = [];
    Response response;
    response = await Dio().get(
      "$questionDetails?student_id=$id&file_id=$qId",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(QuestionDetails.fromJson(element));
      });
    }
    return list;
  }

  Future<List<Books>?> getBooks({String? id}) async {
    List<Books> list = [];
    Response response;
    response = await Dio().get(
      "$books?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(Books.fromJson(element));
      });
    }
    return list;
  }

  Future<List<AskedQuestion>?> getAskedQuestions({String? id}) async {
    List<AskedQuestion> list = [];
    Response response;
    response = await Dio().get(
      "$askedQuestions?student_id=$id",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(AskedQuestion.fromJson(element));
      });
    }
    return list;
  }

  Future<List<AskedQuestionDetails>> getAskedQuestionsDetails(
      {String? id, String? qid}) async {
    List<AskedQuestionDetails> list = [];
    Response response;
    response = await Dio().get(
      "$books?student_id=$id&&msg_id=$qid",
    );
    var data = response.data;
    if (response.data != null) {
      data.forEach((element) {
        list.add(AskedQuestionDetails.fromJson(element));
      });
    }
    return list;
  }
  Future<List<ActivitiesListModel>> getStudentHomeWorksList() async {
    List<ActivitiesListModel> list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = await prefs.getString("id");
    Response response;
    response = await Dio().get(
      "$getHomeWorksURL?student_id=$userId",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(ActivitiesListModel.fromJson(element));
    });
    return list;
  }
  Future<ActivitiesDetailedModel> getHomeWorkDetails( String homeWorkId) async {
    ActivitiesDetailedModel data;
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");
    response = await Dio().get(
      "$getHomeWorkDetailURL?student_id=$userId&homework_id=$homeWorkDetails",
    );
    var resData = response.data;
    data = ActivitiesDetailedModel.fromJson(resData[0]);
    return data;
  }
  Future<SchadulesStudentModel?> getSchadules() async {
    SchadulesStudentModel data;
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");
    response = await Dio().get(
      "$getSchadulesURL?student_id=$userId",
    );
    print("$getSchadulesURL?student_id=$userId");
    var resData = response.data;
    if(resData != null) {
      data = SchadulesStudentModel.fromJson(resData[0]);
      return data;
    }else{
      return null;
    }
  }
}
