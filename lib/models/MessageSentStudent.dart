class MessageSentStudent {
    MessageSentStudent({
        this.msgId,
        this.to,
        this.title,
        this.date,
    });

    String? msgId;
    String? to;
    String? title;
    DateTime? date;

    factory MessageSentStudent.fromJson(Map<String, dynamic> json) => MessageSentStudent(
        msgId: json["msg_id"],
        to: json["to"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
    );

}
