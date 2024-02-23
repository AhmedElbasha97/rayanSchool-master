class Schedule {
  Schedule({
    this.day,
    this.class1,
    this.class2,
    this.class3,
    this.class4,
    this.class5,
    this.class6,
    this.class7,
    this.class8,
  });

  String? day;
  dynamic class1;
  dynamic class2;
  dynamic class3;
  dynamic class4;
  dynamic class5;
  dynamic class6;
  dynamic class7;
  dynamic class8;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        day: json["Day"],
        class1: json["class1"],
        class2: json["class2"],
        class3: json["class3"],
        class4: json["class4"],
        class5: json["class5"],
        class6: json["class6"],
        class7: json["class7"],
        class8: json["class8"],
      );
}
