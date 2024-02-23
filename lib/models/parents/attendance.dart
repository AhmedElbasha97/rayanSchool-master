class Attendance {
  Attendance({
    this.date,
    this.status,
  });

  DateTime? date;
  String? status;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        date: DateTime.parse(json["date"]),
        status: json["status"],
      );
}
