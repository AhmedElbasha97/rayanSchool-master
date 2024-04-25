import 'dart:convert';

List<SchoolSocialMediaLinkModel> schoolSocialMediaLinkModelFromJson(String str) => List<SchoolSocialMediaLinkModel>.from(json.decode(str).map((x) => SchoolSocialMediaLinkModel.fromJson(x)));

String schoolSocialMediaLinkModelToJson(List<SchoolSocialMediaLinkModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolSocialMediaLinkModel {
  String? facebook;
  String? twitter;
  String? youtube;
  String? instagram;

  SchoolSocialMediaLinkModel({
    this.facebook,
    this.twitter,
    this.youtube,
    this.instagram,
  });

  factory SchoolSocialMediaLinkModel.fromJson(Map<String, dynamic> json) => SchoolSocialMediaLinkModel(
    facebook: json["facebook"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    instagram: json["instagram"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "twitter": twitter,
    "youtube": youtube,
    "instagram": instagram,
  };
}