class SubjectDetails {
  SubjectDetails({
    this.title,
    this.description,
    this.image,
  });

  String title;
  String description;
  String image;

  factory SubjectDetails.fromJson(Map<String, dynamic> json) => SubjectDetails(
        title: json["title"],
        description: json["description"],
        image: json["image"],
      );
}
