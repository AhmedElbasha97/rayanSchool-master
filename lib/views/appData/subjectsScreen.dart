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
  List<Subjects>? subjects = [];
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
            : subjects?.isEmpty??true?
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
                  ?"no weekly messages available":"لا يوجد رسائل أسبوعية متوفرة الآن",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20

                ),),
            ],
          ),
        ):ListView.separated(
                itemCount: subjects?.length??0,
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pushPage(
                            context,
                            SubjectDetailsScreen(
                              id: subjects?[index].id,
                            ));
                      },
                      child: ListTile(
                        title: Text("${subjects?[index].miName}"),
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
