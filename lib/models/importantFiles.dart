class ImportantFile {
    ImportantFile({
        this.title,
        this.desc,
        this.file,
    });

    String title;
    String desc;
    String file;

    factory ImportantFile.fromJson(Map<String, dynamic> json) => ImportantFile(
        title: json["title"],
        desc: json["desc"],
        file: json["file"],
    );

}
