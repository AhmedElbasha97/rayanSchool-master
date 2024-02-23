import 'package:flutter/material.dart';
import 'package:rayanSchool/models/schedule.dart';
import 'package:rayanSchool/services/teacherSchedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherSchedule extends StatefulWidget {
  @override
  _TeacherScheduleState createState() => _TeacherScheduleState();
}

class _TeacherScheduleState extends State<TeacherSchedule> {
  bool isLoading = true;
  List<Schedule> schedule = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    schedule = await TeacherScheduleService().getSchedule(id: id??"");
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: schedule.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${schedule[index].day}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Text("${schedule[index].class1??""}"),
                        Text("${schedule[index].class2??""}"),
                        Text("${schedule[index].class3??""}"),
                        Text("${schedule[index].class4??""}"),
                        Text("${schedule[index].class5??""}"),
                        Text("${schedule[index].class6??""}"),
                        Text("${schedule[index].class7??""}"),
                        Text("${schedule[index].class8??""}"),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
    );
  }
}
