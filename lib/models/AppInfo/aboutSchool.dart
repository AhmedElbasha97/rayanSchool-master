class AboutSchool {
  AboutSchool({
    this.title,
    this.description,
    this.image,
  });

  String title;
  String description;
  String image;

  factory AboutSchool.fromJson(Map<String, dynamic> json) => AboutSchool(
        title: json["title"],
        description: json["description"],
        image: json["image"],
      );
}
