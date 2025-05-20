import 'dart:convert';

List<HomeWorkDetails> homeWorkDetailsFromJson(String str) => List<HomeWorkDetails>.from(json.decode(str).map((x) => HomeWorkDetails.fromJson(x)));

String homeWorkDetailsToJson(List<HomeWorkDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeWorkDetails {
  String? id;
  String? title;
  DateTime? date;
  String? teacherName;
  String? homeworkDet;
  String? homeworkFile;

  HomeWorkDetails({
    this.id,
    this.title,
    this.date,
    this.teacherName,
    this.homeworkDet,
    this.homeworkFile,
  });

  factory HomeWorkDetails.fromJson(Map<String, dynamic> json) => HomeWorkDetails(
    id: json["id"],
    title: json["title"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    teacherName: json["teacher_name"],
    homeworkDet: json["homework_det"],
    homeworkFile: json["homework_file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "teacher_name": teacherName,
    "homework_det": homeworkDet,
    "homework_file": homeworkFile,
  };
}