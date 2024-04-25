import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/MessageSentStudent.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:rayanSchool/services/messagesService.dart';
import 'package:rayanSchool/views/loggedUser/Messages/sentMessageDetailsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentMessagesScreen extends StatefulWidget {
  final int type;
  SentMessagesScreen({this.type = 1});
  @override
  _SentMessagesScreenState createState() => _SentMessagesScreenState();
}

class _SentMessagesScreenState extends State<SentMessagesScreen> {
  bool isLoading = true;
  List<MessageSentStudent> messages = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    messages = widget.type != 1
        ? await ParentService().getSentMessages(
            id: id,
          )
        : await MessagesService().getSentMessages(
            id: id,
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
                ?"no messages available":"لا يوجد رسأل متوفره لان",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ): ListView.separated(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      pushPage(
                          context,
                          SentMessageDetails(
                            type: widget.type,
                            id: messages[index].msgId,
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
