class QuestionBankTeacher {
  QuestionBankTeacher({
    this.id,
    this.title,
    this.date,
    this.questionBankTeacherClass,
  });

  String? id;
  String? title;
  String? date;
  String? questionBankTeacherClass;

  factory QuestionBankTeacher.fromJson(Map<String, dynamic> json) =>
      QuestionBankTeacher(
        id: json["id"] == null ? "" : json["id"],
        title: json["title"] == null ? "" : json["title"],
        date: json["date"] == null ? "" : json["date"],
        questionBankTeacherClass: json["class"] == null ? "" : json["class"],
      );
}
