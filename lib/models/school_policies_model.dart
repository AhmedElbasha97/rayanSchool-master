import 'dart:convert';

List<SchoolPoliciesModel> schoolPoliciesModelFromJson(String str) => List<SchoolPoliciesModel>.from(json.decode(str).map((x) => SchoolPoliciesModel.fromJson(x)));

String schoolPoliciesModelToJson(List<SchoolPoliciesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchoolPoliciesModel {
  String? id;
  String? title;
  String? brief;

  SchoolPoliciesModel({
    this.id,
    this.title,
    this.brief,
  });

  factory SchoolPoliciesModel.fromJson(Map<String, dynamic> json) => SchoolPoliciesModel(
    id: json["id"],
    title: json["title"],
    brief: json["brief"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "brief": brief,
  };
}
