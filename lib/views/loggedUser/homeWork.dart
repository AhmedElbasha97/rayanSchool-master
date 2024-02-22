import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/globals/widgets/homeWorkCard.dart';
import 'package:rayanSchool/models/homeWork.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:rayanSchool/views/loggedUser/HomeWorkDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWorkScreen extends StatefulWidget {
  @override
  _HomeWorkScreenState createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {
  bool isLoading = true;
  List<HomeWork> homeworks = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    homeworks = await LoggedUser().getHomeWorks(id: id);
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
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: homeworks.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    pushPage(
                        context,
                        HomeWorkDetailsScreen(
                          id: homeworks[index].id,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomeWorkCard(
                      title: "${homeworks[index].title ?? ""}",
                      date: "${homeworks[index].date ?? ""}",
                      teacherName: "${homeworks[index].teacherName ?? ""}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
