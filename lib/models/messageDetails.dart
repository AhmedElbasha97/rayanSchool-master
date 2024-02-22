class MessageDetails {
  MessageDetails({
    this.from,
    this.title,
    this.text,
    this.date,
  });

  String from;
  String title;
  String text;
  DateTime date;

  factory MessageDetails.fromJson(Map<String, dynamic> json) => MessageDetails(
        from: json["from"],
        title: json["title"],
        text: json["text"],
        date: DateTime.parse(json["date"]),
      );
}
