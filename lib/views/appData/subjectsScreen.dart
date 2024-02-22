import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/AppInfo/subject.dart';
import 'package:rayanSchool/services/appInfoService.dart';
import 'package:rayanSchool/views/appData/subjectDetails.dart';

class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  bool isLoading = true;
  List<Subjects> subjects = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    subjects = await AppInfoService().getSubjects();
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
                itemCount: subjects.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pushPage(
                            context,
                            SubjectDetailsScreen(
                              id: subjects[index].id,
                            ));
                      },
                      child: ListTile(
                        title: Text("${subjects[index].miName}"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ));
  }
}
