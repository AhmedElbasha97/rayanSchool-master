class HomeWorkDetails {
  HomeWorkDetails({
    this.id,
    this.title,
    this.date,
    this.teacherName,
    this.homeworkDet,
    this.homeworkFile,
  });

  String id;
  String title;
  DateTime date;
  dynamic teacherName;
  String homeworkDet;
  String homeworkFile;

  factory HomeWorkDetails.fromJson(Map<String, dynamic> json) =>
      HomeWorkDetails(
        id: json["id"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        teacherName: json["teacher_name"],
        homeworkDet: json["homework_det"],
        homeworkFile: json["homework_file"],
      );
}
