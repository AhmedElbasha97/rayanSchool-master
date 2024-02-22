class SentMessagesTeacher {
  SentMessagesTeacher({
    this.msgId,
    this.to,
    this.title,
    this.date,
  });

  String msgId;
  String to;
  String title;
  String date;

  factory SentMessagesTeacher.fromJson(Map<String, dynamic> json) =>
      SentMessagesTeacher(
        msgId: json["msg_id"] == null ? "" : json["msg_id"],
        to: json["to"] == null ? "" : json["to"],
        title: json["title"] == null ? "" : json["title"],
        date: json["date"] == null ? "" : json["date"],
      );
}
