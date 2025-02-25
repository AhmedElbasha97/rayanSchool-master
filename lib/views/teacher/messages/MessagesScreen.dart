import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/teacher/sentMessages.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:rayanSchool/views/teacher/messages/messageDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagesTeacherScreen extends StatefulWidget {
  @override
  _MessagesTeacherScreenState createState() => _MessagesTeacherScreenState();
}

class _MessagesTeacherScreenState extends State<MessagesTeacherScreen> {
  bool isLoading = true;
  List<SentMessagesTeacher> messages = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    messages = await TeacherService().getSentMessages(
      id: id??"",
    );
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
          : messages.isEmpty??true?
      Container(
        height: MediaQuery.of(context).size.height*0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/noMessages.png"),
            ),
            SizedBox(height: 20,),
            Text(Localizations.localeOf(context).languageCode == "en"
                ?"no messages available":"لا يوجد رسائل متوفرة الآن",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ):ListView.separated(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      print(messages[index].msgId);
                      pushPage(
                          context,
                          MessageDetailsScreen(
                            id: "${messages[index].msgId}",
                          ));
                    },
                    title: Text("${messages[index].title}"),
                    trailing: Text("${messages[index].date}"),
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
