import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/models/questionDetails.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionDetailsScreen extends StatefulWidget {
  final String id;
  QuestionDetailsScreen({this.id});
  @override
  _QuestionDetailsScreenState createState() => _QuestionDetailsScreenState();
}

class _QuestionDetailsScreenState extends State<QuestionDetailsScreen> {
  bool isLoading = true;
  List<QuestionDetails> qustions = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    qustions =
        await LoggedUser().getQuestionsDetails(id: id, qId: widget.id ?? "");
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
              itemCount: qustions.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${qustions[index].title}"),
                        Text("${qustions[index].date}"),
                        Html(data: "${qustions[index].fileDet}"),
                        qustions[index].fileLink != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppBtn(
                                  label: AppLocalizations.of(context)
                                      .translate('download'),
                                  onClick: () async {
                                    if (await canLaunch(
                                        "${qustions[index].fileLink}")) {
                                      await launch(
                                          "${qustions[index].fileLink}");
                                    } else {
                                      throw 'Could not launch ${qustions[index].fileLink}';
                                    }
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
