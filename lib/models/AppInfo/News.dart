class News {
  News({
    this.id,
    this.title,
    this.brief,
  });

  String id;
  String title;
  String brief;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        brief: json["brief"] == null ? null : json["brief"],
      );
}
