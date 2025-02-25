import 'dart:convert';

List<Videos> videosFromJson(String str) => List<Videos>.from(json.decode(str).map((x) => Videos.fromJson(x)));

String videosToJson(List<Videos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Videos {
  dynamic id;
  String? title;
  String? img;
  String? link;
  String? file;

  Videos({
    this.id,
    this.title,
    this.img,
    this.link,
    this.file,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    id: json["id"],
    title: json["title"],
    img: json["img"],
    link: json["link"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "img": img,
    "link": link,
    "file": file,
  };
}