class AskedQuestionDetails {
  AskedQuestionDetails({
    this.from,
    this.title,
    this.text,
    this.date,
  });

  String? from;
  String? title;
  String? text;
  DateTime? date;

  factory AskedQuestionDetails.fromJson(Map<String, dynamic> json) =>
      AskedQuestionDetails(
        from: json["from"] == null ? null : json["from"],
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );
}
