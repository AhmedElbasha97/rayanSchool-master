import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/widgets/homeWorkCard.dart';
import 'package:rayanSchool/models/teacher/homeWork.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:rayanSchool/views/teacher/homework/homework_details/homework_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//this screen for teacher to show all homeworks that he added and when click on any homework it will show details of it
//but the school asked to remove the add homework button from the app and make it only for admin to add homework and teacher can only see it and not add it so i removed the add homework button from the app and make it only for admin to add homework and teacher can only see it and not add it
class HomeWorkScreen extends StatefulWidget {
  @override
  _HomeWorkScreenState createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  bool isLoading = true;
  List<HomeWorkTeacher> homeworks = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    homeworks = await TeacherService().getHomeWork(id: id);
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
          : homeworks.isEmpty?
      Container(
        height: MediaQuery.of(context).size.height*0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/noData.png"),
            ),
            SizedBox(height: 20,),
            Text(Localizations.localeOf(context).languageCode == "en"
                ?"no Homework available":"لا يوجد واجب منزلى متوفره لان",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ):ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: homeworks.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    pushPage(
                        context,
                        HomeWorkDetailsScreen(
                          id: homeworks[index].id??"",
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomeWorkCard(
                      title: "${homeworks[index].title ?? ""}",
                      date: "${homeworks[index].date ?? ""}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
