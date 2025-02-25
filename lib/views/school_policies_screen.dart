import 'package:flutter/material.dart';
import 'package:rayanSchool/views/school_policies_details_screen.dart';

import '../globals/helpers.dart';
import '../models/AppInfo/subject.dart';
import '../models/school_policies_model.dart';
import '../services/appInfoService.dart';

class SchoolPoliciesScreen extends StatefulWidget {
  const SchoolPoliciesScreen({super.key});

  @override
  State<SchoolPoliciesScreen> createState() => _SchoolPoliciesScreenState();
}

class _SchoolPoliciesScreenState extends State<SchoolPoliciesScreen> {
  bool isLoading = true;
  List<SchoolPoliciesModel>? subjects = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    subjects = await AppInfoService().getSchoolPolicies();
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
                  ?"no School Policies available":"لا يوجد سياسات مدرسية متوفرة الآن",
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
                      SchoolPoliciesDetailsScreen(
                        id: subjects?[index].id,
                      ));
                },
                child: ListTile(
                  title: Text("${subjects?[index].title}"),
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
