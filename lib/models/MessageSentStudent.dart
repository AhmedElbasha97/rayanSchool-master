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
    String? date;

    factory MessageSentStudent.fromJson(Map<String, dynamic> json) => MessageSentStudent(
        msgId: json["msg_id"],
        to: json["to"],
        title: json["title"],
        date: "${json["date"]}",
    );

}
