import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:html/parser.dart' as html_parser; // To parse HTML
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
import '../models/AppInfo/subjectDetails.dart';
import '../models/school_policies_details_model.dart';
import '../services/appInfoService.dart';

class SchoolPoliciesDetailsScreen extends StatefulWidget {
  final String? id;

  const SchoolPoliciesDetailsScreen({Key? key, this.id}) : super(key: key);

  @override
  State<SchoolPoliciesDetailsScreen> createState() => _SchoolPoliciesDetailsScreenState();
}

class _SchoolPoliciesDetailsScreenState extends State<SchoolPoliciesDetailsScreen> {
  bool isLoading = true;
  List<SchoolPoliciesDetailsModel> details = [];
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
    details = await AppInfoService().getSchoolPoliciesDetails(id: widget.id);
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${details[index].image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("${details[index].title}"),
                  SizedBox(
                    height: 5,
                  ),
                  Linkify(
                    onOpen: (link) async {
                      Uri uri = Uri.parse(link.url);
                      await _onOpenLink(uri);
                    },
                    text: extractTextFromHtml("${details[index].description}"), // Convert HTML to plain text
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    linkStyle: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                  SizedBox(height: 10,),
                  details[index].file==""?SizedBox():Center(
                    child: InkWell(
                      onTap: () async {
                        Uri uri = Uri.parse("${details[index].file}");
                        await _onOpenLink(uri);
                      },

                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            child: Text(
                              "${Localizations.localeOf(context).languageCode == "en"
                                  ?"download file":"تحميل الملف"}",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
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
