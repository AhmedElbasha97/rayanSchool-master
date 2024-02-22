import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/widgets/homeWorkCard.dart';
import 'package:rayanSchool/models/importantFiles.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesImportantScreen extends StatefulWidget {
  @override
  _FilesImportantScreenState createState() => _FilesImportantScreenState();
}

class _FilesImportantScreenState extends State<FilesImportantScreen> {
  bool isLoading = true;
  List<ImportantFile> files = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    files = await LoggedUser().getImportantFiles(id: id);
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
              itemCount: files.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (await canLaunch("${files[index].file}")) {
                        await launch("${files[index].file}");
                      } else {
                        throw 'Could not launch ${files[index].file}';
                      }
                    },
                    child: HomeWorkCard(
                      title: "${files[index].title}",
                      date: "${files[index].desc}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
