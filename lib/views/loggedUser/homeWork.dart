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
    String? id = prefs.getString("id");
    homeworks = await LoggedUser().getHomeWorks(id: id??"");
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
          :  homeworks.isEmpty??true?
      Container(
        height: MediaQuery.of(context).size.height*0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/noBooks.png"),
            ),
            SizedBox(height: 20,),
            Text(Localizations.localeOf(context).languageCode == "en"
                ?"no homework available":"لا يوجد واجب مدرسى متوفره لان",
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
                      teacherName: "${homeworks[index].teacherName ?? ""}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
