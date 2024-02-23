class Files {
  Files({
    this.id,
    this.title,
    this.date,
  });

  String? id;
  String? title;
  String? date;

  factory Files.fromJson(Map<String, dynamic> json) => Files(
        id: json["id"],
        title: json["title"],
        date: json["date"],
      );
}
