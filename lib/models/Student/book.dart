class Books {
  Books({
    this.title,
    this.file,
  });

  String title;
  String file;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        title: json["title"] == null ? null : json["title"],
        file: json["file"] == null ? null : json["file"],
      );
}
