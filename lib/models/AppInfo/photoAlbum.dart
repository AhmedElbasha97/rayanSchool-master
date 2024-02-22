class PhotoAlbum {
  PhotoAlbum({
    this.id,
    this.title,
    this.img,
  });

  String id;
  String title;
  String img;

  factory PhotoAlbum.fromJson(Map<String, dynamic> json) => PhotoAlbum(
        id: json["id"],
        title: json["title"],
        img: json["img"],
      );
}
