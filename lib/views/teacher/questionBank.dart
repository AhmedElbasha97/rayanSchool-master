import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/widgets/homeWorkCard.dart';
import 'package:rayanSchool/models/teacher/questionBank.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionBankScreen extends StatefulWidget {
  @override
  _QuestionBankScreenState createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  bool isLoading = true;
  List<QuestionBankTeacher>? questions = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    questions = await TeacherService().getQuestionBank(id: id??"");
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
          : questions?.isEmpty??true?
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
                ?"no Questions available":"لا يوجد أسأله متوفره لان",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ):ListView.builder(
              itemCount: questions?.length??0,
              padding: EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: HomeWorkCard(
                      title: "${questions?[index].title}",
                      date: "${questions?[index].date}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
