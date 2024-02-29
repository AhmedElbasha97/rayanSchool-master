import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String? id;
  String? title;
  String? text;
  String? view;
  String? date;

  NotificationModel({
    this.id,
    this.title,
    this.text,
    this.view,
    this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    title: json["title"],
    text: json["text"],
    view: json["view"],
    date: json["date"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "text": text,
    "view": view,
    "date": date,
  };
}