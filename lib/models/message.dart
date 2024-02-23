class Messages {
  Messages({
    this.msgId,
    this.from,
    this.title,
    this.date,
  });

  String? msgId;
  String? from;
  String? title;
  DateTime? date;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        msgId: json["msg_id"],
        from: json["from"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
      );
}
