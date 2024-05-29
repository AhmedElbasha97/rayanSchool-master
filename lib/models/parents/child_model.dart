import 'dart:convert';

List<ChildModel> childModelFromJson(String str) => List<ChildModel>.from(json.decode(str).map((x) => ChildModel.fromJson(x)));

String childModelToJson(List<ChildModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChildModel {
  String? id;
  String? name;
  String? childModelClass;

  ChildModel({
    this.id,
    this.name,
    this.childModelClass,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) => ChildModel(
    id: json["id"],
    name: json["name"],
    childModelClass: json["class"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "class": childModelClass,
  };
}
