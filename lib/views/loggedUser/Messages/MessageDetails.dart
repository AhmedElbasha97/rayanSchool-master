import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:html/parser.dart' as html_parser; // To parse HTML
import 'package:html/dom.dart' as dom;
import 'package:rayanSchool/models/messageDetails.dart';
import 'package:rayanSchool/services/ParentsService.dart';
import 'package:rayanSchool/services/messagesService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../globals/helpers.dart';

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
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("تنبيه"),
          content: Text("لا يمكن فتح الرابط"),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // تنفيذ الإجراء وإغلاق التنبيه
                // ضع هنا الكود الخاص بتنفيذ الإجراء المطلوب
              },
              child: Text("موافق"),
            ),
          ],
        );
      },
    );
  }
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    msg = widget.type != 1
        ? await ParentService().getMessageDetails(id: id, msgId: widget.id)
        : await MessagesService().getMessageDetails(id: id, msgId: widget.id);
    isLoading = false;
    setState(() {});
  }
  String extractTextFromHtml(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? ""; // Extract plain text
  }
  Future<void> _onOpenLink(Uri url) async {
    if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
    } else {
      showAlert( context);
    }
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
                    Linkify(
                      onOpen: (link) async {
                        Uri uri = Uri.parse(link.url);
                        await _onOpenLink(uri);
                      },
                      text: extractTextFromHtml("${msg[index].text}"), // Convert HTML to plain text
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      linkStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
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
