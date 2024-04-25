import 'dart:convert';

List<ActivitiesDetailedModel> activitiesDetailedModelFromJson(String str) => List<ActivitiesDetailedModel>.from(json.decode(str).map((x) => ActivitiesDetailedModel.fromJson(x)));

String activitiesDetailedModelToJson(List<ActivitiesDetailedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivitiesDetailedModel {
  String? title;
  String? description;
  String? image;

  ActivitiesDetailedModel({
    this.title,
    this.description,
    this.image,
  });

  factory ActivitiesDetailedModel.fromJson(Map<String, dynamic> json) => ActivitiesDetailedModel(
    title: json["title"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "image": image,
  };
}