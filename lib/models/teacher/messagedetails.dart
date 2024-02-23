class MessageDetailsTeacherModel {
  MessageDetailsTeacherModel({
    this.to,
    this.title,
    this.text,
    this.date,
  });

  String? to;
  String? title;
  String? text;
  String? date;

  factory MessageDetailsTeacherModel.fromJson(Map<String, dynamic> json) =>
      MessageDetailsTeacherModel(
          to: json["to"] == null ? "" : json["to"],
          title: json["title"] == null ? "" : json["title"],
          text: json["text"] == null ? "" : json["text"],
          date: json["date"] == null ? "" : json["date"]);
}
