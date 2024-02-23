class HomeWorkTeacher {
  HomeWorkTeacher({
    this.id,
    this.title,
    this.date,
    this.homeWorkTeacherClass,
  });

  String? id;
  String? title;
  String? date;
  String? homeWorkTeacherClass;

  factory HomeWorkTeacher.fromJson(Map<String, dynamic> json) =>
      HomeWorkTeacher(
        id: json["id"] == null ? "" : json["id"],
        title: json["title"] == null ? "" : json["title"],
        date: json["date"] == null ? "" : json["date"],
        homeWorkTeacherClass: json["class"] == null ? "" : json["class"],
      );
}
