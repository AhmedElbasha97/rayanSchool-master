import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rayanSchool/models/AppInfo/subjectDetails.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final String id;
  SubjectDetailsScreen({this.id});
  @override
  _SubjectDetailsScreenState createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  bool isLoading = true;
  List<SubjectDetails> details = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    details = await AppInfoService().getSubjectDetails(id: widget.id);
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
              itemCount: details.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("${details[index].image}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${details[index].title}"),
                        SizedBox(
                          height: 5,
                        ),
                        Html(data: "${details[index].description}"),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
