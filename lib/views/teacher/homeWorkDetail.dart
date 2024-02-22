import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/models/teacher/HomeWorkDetails.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWorkDetailsScreen extends StatefulWidget {
  final String id;
  HomeWorkDetailsScreen({this.id = ""});
  @override
  _HomeWorkDetailsScreenState createState() => _HomeWorkDetailsScreenState();
}

class _HomeWorkDetailsScreenState extends State<HomeWorkDetailsScreen> {
  bool isLoading = true;
  List<HomeWorkDetailsTeacherModel> homework = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    homework = await TeacherService()
        .getHomeworkDetails(id: id, homeworkId: widget.id);
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
              itemCount: homework.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${homework[index].title}"),
                        Text("${homework[index].date}"),
                        Text("${homework[index].teacherName ?? ""}"),
                        Html(data: "${homework[index].homeworkDet}"),
                        homework[index].homeworkFile != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppBtn(
                                  label: AppLocalizations.of(context)
                                      .translate('download'),
                                  onClick: () async {
                                    if (await canLaunch(
                                        "${homework[index].homeworkFile}")) {
                                      await launch(
                                          "${homework[index].homeworkFile}");
                                    } else {
                                      throw 'Could not launch ${homework[index].homeworkFile}';
                                    }
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
