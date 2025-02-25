import 'dart:convert';

List<SchoolSocialMediaLinkModel> schoolSocialMediaLinkModelFromJson(String str) => List<SchoolSocialMediaLinkModel>.from(json.decode(str).map((x) => SchoolSocialMediaLinkModel.fromJson(x)));

String schoolSocialMediaLinkModelToJson(List<SchoolSocialMediaLinkModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolSocialMediaLinkModel {
  String? facebook;
  String? twitter;
  String? youtube;
  String? instagram;
  String? whatsapp;


  SchoolSocialMediaLinkModel({
    this.facebook,
    this.twitter,
    this.youtube,
    this.instagram,
    this.whatsapp,
  });

  factory SchoolSocialMediaLinkModel.fromJson(Map<String, dynamic> json) => SchoolSocialMediaLinkModel(
    facebook: json["facebook"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    instagram: json["instagram"],
    whatsapp: json["whatsapp"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "twitter": twitter,
    "youtube": youtube,
    "instagram": instagram,
    "whatsapp": whatsapp,
  };
}