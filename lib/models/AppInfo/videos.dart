class Videos {
  Videos({
    this.id,
    this.title,
    this.img,
    this.link,
  });

  dynamic id;
  String? title;
  String? img;
  String? link;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        id: json["id"],
        title: json["title"],
        img: json["img"],
        link: json["link"],
      );
}
