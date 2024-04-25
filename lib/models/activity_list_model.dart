import 'dart:convert';

List<ActivitiesListModel> activitiesListModelFromJson(String str) => List<ActivitiesListModel>.from(json.decode(str).map((x) => ActivitiesListModel.fromJson(x)));

String activitiesListModelToJson(List<ActivitiesListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivitiesListModel {
  String? id;
  String? miName;

  ActivitiesListModel({
    this.id,
    this.miName,
  });

  factory ActivitiesListModel.fromJson(Map<String, dynamic> json) => ActivitiesListModel(
    id: json["id"],
    miName: json["mi_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mi_name": miName,
  };
}
