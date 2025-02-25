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
  List<AskedQuestion>? question = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
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
          :  question?.isEmpty??true?
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
                ?"no questions available":"لا يوجد أسألة متوفرة الآن",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ):ListView.separated(
              itemCount: question?.length??0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () async {
                      pushPage(
                          context,
                          AskedQuestionsDetailsScreen(
                              id: question?[index].msgId??""));
                    },
                    title: Text("${question?[index].title??""}"),
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
