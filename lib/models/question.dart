class Question {
  Question({
    this.id,
    this.title,
    this.date,
  });

  String? id;
  String? title;
  String? date;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        title: json["title"],
        date: json["date"],
      );
}
