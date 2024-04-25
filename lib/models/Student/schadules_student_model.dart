import 'dart:convert';

List<SchadulesStudentModel> schadulesStudentModelFromJson(String str) => List<SchadulesStudentModel>.from(json.decode(str).map((x) => SchadulesStudentModel.fromJson(x)));

String schadulesStudentModelToJson(List<SchadulesStudentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SchadulesStudentModel {
  String? img;
  String? notes;

  SchadulesStudentModel({
    this.img,
    this.notes,
  });

  factory SchadulesStudentModel.fromJson(Map<String, dynamic> json) => SchadulesStudentModel(
    img: json["img"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "notes": notes,
  };
}
