class Teachers {
  Teachers({
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  String? id;
  String? name;
  String? phone;
  String? email;

  factory Teachers.fromJson(Map<String, dynamic> json) => Teachers(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
      );
}
