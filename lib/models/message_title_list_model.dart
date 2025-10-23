
import 'dart:convert';

MessageTitleModel messageTitleModelFromJson(String str) => MessageTitleModel.fromJson(json.decode(str));

String messageTitleModelToJson(MessageTitleModel data) => json.encode(data.toJson());

class MessageTitleModel {
  String? title;
  MessageTitleModel({
    this.title,
  });

  factory MessageTitleModel.fromJson(Map<String, dynamic> json) => MessageTitleModel(
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "count": title,
  };
}