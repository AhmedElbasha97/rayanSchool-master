class Category {
  Category({
    this.id,
    this.ctgName,
  });

  String? id;
  String? ctgName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        ctgName: json["ctg_name"],
      );
}
