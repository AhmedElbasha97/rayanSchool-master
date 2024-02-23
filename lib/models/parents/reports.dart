class Report {
  Report({
    this.reportId,
    this.student,
    this.teacher,
    this.date,
  });

  String? reportId;
  String? student;
  String? teacher;
  String? date;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        reportId: json["report_id"],
        student: json["student"],
        teacher: json["teacher"],
        date: json["date"],
      );
}
