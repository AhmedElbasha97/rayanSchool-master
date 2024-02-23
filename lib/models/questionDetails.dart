class QuestionDetails {
    QuestionDetails({
        this.id,
        this.title,
        this.date,
        this.fileDet,
        this.fileLink,
    });

    String? id;
    String? title;
    DateTime? date;
    String? fileDet;
    String? fileLink;

    factory QuestionDetails.fromJson(Map<String, dynamic> json) => QuestionDetails(
        id: json["id"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        fileDet: json["file_det"],
        fileLink: json["file_link"],
    );

}
