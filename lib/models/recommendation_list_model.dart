import 'dart:convert';

List<RecommendationListModel> recommendationListModelFromJson(String str) => List<RecommendationListModel>.from(json.decode(str).map((x) => RecommendationListModel.fromJson(x)));

String recommendationListModelToJson(List<RecommendationListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecommendationListModel {
  String? id;
  String? student;
  String? teacher;
  String? subject;
  String? title;
  String? notes;
  String? date;

  RecommendationListModel({
    this.id,
    this.student,
    this.teacher,
    this.subject,
    this.title,
    this.notes,
    this.date,
  });

  factory RecommendationListModel.fromJson(Map<String, dynamic> json) => RecommendationListModel(
    id: json["id"],
    student: json["student"],
    teacher: json["teacher"],
    subject: json["subject"],
    title: json["title"],
    notes: json["notes"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student": student,
    "teacher": teacher,
    "subject": subject,
    "title": title,
    "notes": notes,
    "date": date,
  };
}