import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rayanSchool/models/parents/reportDetails.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportsDetailScreen extends StatefulWidget {
  final String? id;
  ReportsDetailScreen({this.id});
  @override
  _ReportsDetailScreenState createState() => _ReportsDetailScreenState();
}

class _ReportsDetailScreenState extends State<ReportsDetailScreen> {
  bool isLoading = true;
  List<ReportDetails> reports = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    reports =
        await ParentService().getReportDetails(id: id, reportId: widget.id);
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
              itemCount: reports.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${reports[index].student}"),
                        Text("${reports[index].date}"),
                        Text("${reports[index].teacher ?? ""}"),
                        Html(data: "${reports[index].text}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
