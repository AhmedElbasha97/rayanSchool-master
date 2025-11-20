import 'dart:convert';

class SentMessageDetailsModel {
  final String? msgId;
  final String? from;
  final String? msg;
  final String? date;

  SentMessageDetailsModel({
    this.msgId,
    this.from,
    this.msg,
    this.date,
  });

  SentMessageDetailsModel copyWith({
    String? msgId,
    String? from,
    String? msg,
    String? date,
  }) =>
      SentMessageDetailsModel(
        msgId: msgId ?? this.msgId,
        from: from ?? this.from,
        msg: msg ?? this.msg,
        date: date ?? this.date,
      );

  factory SentMessageDetailsModel.fromRawJson(String str) => SentMessageDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SentMessageDetailsModel.fromJson(Map<String, dynamic> json) => SentMessageDetailsModel(
    msgId: json["msg_id"],
    from: json["from"],
    msg: json["msg"],
    date:"${ json["date"]}",
  );

  Map<String, dynamic> toJson() => {
    "msg_id": msgId,
    "from": from,
    "msg": msg,
    "date": date,
  };
}
