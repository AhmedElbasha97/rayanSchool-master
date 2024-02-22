class HomeWorkDetailsTeacherModel {
  HomeWorkDetailsTeacherModel({
    this.id,
    this.title,
    this.date,
    this.teacherName,
    this.homeworkDet,
    this.homeworkFile,
  });

  String id;
  String title;
  String date;
  String teacherName;
  String homeworkDet;
  String homeworkFile;

  factory HomeWorkDetailsTeacherModel.fromJson(Map<String, dynamic> json) =>
      HomeWorkDetailsTeacherModel(
        id: json["id"] == null ? "" : json["id"],
        title: json["title"] == null ? "" : json["title"],
        date: json["date"] == null ? "" : json["date"],
        teacherName: json["teacher_name"],
        homeworkDet: json["homework_det"] == null ? "" : json["homework_det"],
        homeworkFile:
            json["homework_file"] == null ? "" : json["homework_file"],
      );
}
