class Photo {
  Photo({
    this.id,
    this.title,
    this.img,
  });

  String? id;
  String? title;
  String? img;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        title: json["title"],
        img: json["img"],
      );
}
