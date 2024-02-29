import 'dart:convert';

NotificationCounterModel notificationCounterModelFromJson(String str) => NotificationCounterModel.fromJson(json.decode(str));

String notificationCounterModelToJson(NotificationCounterModel data) => json.encode(data.toJson());

class NotificationCounterModel {
  int? count;

  NotificationCounterModel({
    this.count,
  });

  factory NotificationCounterModel.fromJson(Map<String, dynamic> json) => NotificationCounterModel(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}