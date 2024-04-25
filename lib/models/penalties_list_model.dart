import 'dart:convert';

List<PenaltiesListModel> penaltiesListModelFromJson(String str) => List<PenaltiesListModel>.from(json.decode(str).map((x) => PenaltiesListModel.fromJson(x)));

String penaltiesListModelToJson(List<PenaltiesListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PenaltiesListModel {
  String? id;
  String? student;
  String? penaltiesListModelClass;
  String? level;
  String? penalty;
  String? action;
  String? notes;
  String? date;

  PenaltiesListModel({
    this.id,
    this.student,
    this.penaltiesListModelClass,
    this.level,
    this.penalty,
    this.action,
    this.notes,
    this.date,
  });

  factory PenaltiesListModel.fromJson(Map<String, dynamic> json) => PenaltiesListModel(
    id: json["id"],
    student: json["student"],
    penaltiesListModelClass: json["class"],
    level: json["level"],
    penalty: json["penalty"],
    action: json["action"],
    notes: json["notes"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student": student,
    "class": penaltiesListModelClass,
    "level": level,
    "penalty": penalty,
    "action": action,
    "notes": notes,
    "date": date,
  };
}
