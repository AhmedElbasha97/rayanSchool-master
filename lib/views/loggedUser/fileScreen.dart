import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/globals/widgets/homeWorkCard.dart';
import 'package:rayanSchool/models/files.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:rayanSchool/views/loggedUser/fileDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilesScreen extends StatefulWidget {
  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  bool isLoading = true;
  List<Files>? files = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    files = await LoggedUser().getFiles(id: id??"");
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
          :files?.isEmpty??true?
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
                ?"no files available":"لا يوجد ملفات متوفرة الآن",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ): ListView.builder(
              itemCount: files?.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      pushPage(
                          context,
                          FileDetailsScreen(
                            id: files?[index].id??"",
                          ));
                    },
                    child: HomeWorkCard(
                      title: "${files?[index].title}",
                      date: "${files?[index].date}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
