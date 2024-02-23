class Subjects {
  Subjects({
    this.id,
    this.miName,
  });

  String? id;
  String? miName;

  factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        id: json["id"],
        miName: json["mi_name"],
      );
}
