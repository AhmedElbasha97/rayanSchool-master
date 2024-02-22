class TeacherReport {
  TeacherReport({
    this.reportId,
    this.student,
    this.date,
    this.text,
  });

  String reportId;
  String student;
  String date;
  String text;

  factory TeacherReport.fromJson(Map<String, dynamic> json) => TeacherReport(
        reportId: json["report_id"],
        student: json["student"],
        date: json["date"],
        text: json["text"],
      );
}
