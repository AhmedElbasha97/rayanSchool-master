import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:rayanSchool/models/teacher/messagedetails.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as html_parser; // To parse HTML
import 'package:html/dom.dart' as dom;
class MessageDetailsScreen extends StatefulWidget {
  final String id;
  MessageDetailsScreen({this.id = ""});
  @override
  _MessageDetailsScreenState createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  bool isLoading = true;
  List<MessageDetailsTeacherModel> msg = [];
  @override
  void initState() {
    super.initState();
    getData();
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
    msg =
        await TeacherService().getMessageDetails(id: id??"", msgId: widget.id);
    print(msg);
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
                        Text("${msg[index].to ?? ""}"),
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
