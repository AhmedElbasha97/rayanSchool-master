import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:rayanSchool/models/messageDetails.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:rayanSchool/services/messagesService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDetailsScreen extends StatefulWidget {
  final String id;
  final int type;
  MessageDetailsScreen({this.id = "", this.type = 1});
  @override
  _MessageDetailsScreenState createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  bool isLoading = true;
  List<MessageDetails> msg = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    msg = widget.type != 1
        ? await ParentService().getMessageDetails(id: id, msgId: widget.id)
        : await MessagesService().getMessageDetails(id: id, msgId: widget.id);
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
              itemCount: msg.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${msg[index].title}"),
                        Text("${msg[index].date}"),
                        Text("${msg[index].from ?? ""}"),
                        Html(data: "${msg[index].text}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
