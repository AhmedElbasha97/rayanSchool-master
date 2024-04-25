import 'dart:convert';

List<HomeworkTeacherListModel> homeworkTeacherListModelFromJson(String str) => List<HomeworkTeacherListModel>.from(json.decode(str).map((x) => HomeworkTeacherListModel.fromJson(x)));

String homeworkTeacherListModelToJson(List<HomeworkTeacherListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeworkTeacherListModel {
  String? id;
  String? title;
  String? date;
  String? homeworkTeacherListModelClass;

  HomeworkTeacherListModel({
    this.id,
    this.title,
    this.date,
    this.homeworkTeacherListModelClass,
  });

  factory HomeworkTeacherListModel.fromJson(Map<String, dynamic> json) => HomeworkTeacherListModel(
    id: json["id"],
    title: json["title"],
    date: json["date"] ,
    homeworkTeacherListModelClass: json["class"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "class": homeworkTeacherListModelClass,
  };
}