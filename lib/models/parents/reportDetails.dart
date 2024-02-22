class ReportDetails {
  ReportDetails({
    this.reportId,
    this.student,
    this.teacher,
    this.date,
    this.text,
  });

  String reportId;
  String student;
  String teacher;
  String date;
  String text;

  factory ReportDetails.fromJson(Map<String, dynamic> json) => ReportDetails(
        reportId: json["report_id"],
        student: json["student"],
        teacher: json["teacher"],
        date: json["date"],
        text: json["text"],
      );
}
