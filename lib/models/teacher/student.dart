class Student {
  Student({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
      );
}
