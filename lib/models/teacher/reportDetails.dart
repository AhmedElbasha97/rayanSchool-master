class TeacherReportDetails {
  TeacherReportDetails({
    this.reportId,
    this.student,
    this.date,
    this.text,
  });

  String? reportId;
  String? student;
  String? date;
  String? text;

  factory TeacherReportDetails.fromJson(Map<String, dynamic> json) =>
      TeacherReportDetails(
        reportId: json["report_id"],
        student: json["student"],
        date: json["date"],
        text: json["text"],
      );
}
