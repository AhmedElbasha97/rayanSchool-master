import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rayanSchool/models/Student/AskedQuestionDetails.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskedQuestionsDetailsScreen extends StatefulWidget {
  final String? id;
  AskedQuestionsDetailsScreen({this.id});
  @override
  _AskedQuestionsDetailsScreenState createState() =>
      _AskedQuestionsDetailsScreenState();
}

class _AskedQuestionsDetailsScreenState
    extends State<AskedQuestionsDetailsScreen> {
  bool isLoading = true;
  List<AskedQuestionDetails> details = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    details = await LoggedUser()
        .getAskedQuestionsDetails(id: id, qid: widget.id ?? "");
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
                        Text("${details[index].title}"),
                        Text("${details[index].date}"),
                        Text("${details[index].from}"),
                        Html(data: "${details[index].text}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
