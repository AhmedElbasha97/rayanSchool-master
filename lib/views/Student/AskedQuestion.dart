import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/Student/AskedQuestion.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:rayanSchool/views/Student/AskedQuestionsDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskedQuestions extends StatefulWidget {
  @override
  _AskedQuestionsState createState() => _AskedQuestionsState();
}

class _AskedQuestionsState extends State<AskedQuestions> {
  bool isLoading = true;
  List<AskedQuestion> question = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    question = await LoggedUser().getAskedQuestions(id: id);
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
              itemCount: question.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () async {
                      pushPage(
                          context,
                          AskedQuestionsDetailsScreen(
                              id: question[index].msgId));
                    },
                    title: Text("${question[index].title}"),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
    );
  }
}
