import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/loggedUser/Messages/sendMessageStudent.dart';
import 'package:rayanSchool/views/parents/AttendanceScreen.dart';
import 'package:rayanSchool/views/parents/ReportsScreen.dart';
import 'package:rayanSchool/views/parents/penalties_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_academic_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/commonStyles.dart';
import '../globals/widgets/loader.dart';
import '../models/parents/child_model.dart';
import '../services/ParentsService.dart';
import 'loggedUser/Messages/MessagesScreen.dart';
import 'loggedUser/Messages/sentMessageScreen.dart';

class MyAccountParent extends StatefulWidget {
  @override
  _MyAccountParentState createState() => _MyAccountParentState();
}

class _MyAccountParentState extends State<MyAccountParent> {
  bool isLoading = true;
  List<ChildModel> childData = [];

  String? chosenChild = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    GetAllChildData();
  }
  nameOfSelectedChild() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.getString("id");

    for(var child in childData){
      if(child.id == userId){
        chosenChild = child.name;
      }
    }

  }
  selectingChild(
      ChildModel child
      ) async {
    chosenChild = child.name??"";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("id",child.id??"");
    setState(() {

    });
  }
  GetAllChildData() async {
    childData = await ParentService().getChildList();
    nameOfSelectedChild();
    isLoading = false;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading?Loader(
          height: MediaQuery.of(context).size.height,
        ):Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              PopupMenuButton<ChildModel>(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.45,
                  minWidth: MediaQuery.of(context).size.width * 0.45,
                ),
                itemBuilder: (context) => childData.map((e) {
                  return PopupMenuItem(
                    value: e,
                    textStyle: TextStyle(
                        color: mainColor,

                        fontWeight: FontWeight.w700),
                    onTap: () {
                      selectingChild(
                          e
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Column(
                        children: [
                          Text(
                            e.name??"",
                            style: TextStyle(
                                color: mainTextColor,

                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          e == childData.last
                              ? const SizedBox()
                              :  Divider(
                            color: mainColor,
                            height: 1,
                            thickness: 1,
                            endIndent: 0,
                            indent: 0,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                color: mainColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.06,
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(1, 1), // Shadow position
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                'الطالب المختار:${
                                    chosenChild
                                }',
                                style: TextStyle(
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: const Offset(0.5, 0.5),
                                        blurRadius: 0.5,
                                        color: Colors.black
                                            .withOpacity(0.5)),
                                  ],
                                  fontSize: 15,
                                  letterSpacing: 0,

                                  color: mainTextColor,
                                ),
                              ),
                            ),
                             Icon(Icons.arrow_downward_sharp,
                                color: mainTextColor, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  pushPage(context, ReportScreen());
                },
                title: Text(
                  AppLocalizations.of(context)?.translate('reports')??"",
                ),
                trailing: Icon(Icons.book),
              ),
              Divider(),
              ListTile(
                  onTap: () {
                    pushPage(context, AttendanceScreen());
                  },
                  title: Text(
                    AppLocalizations.of(context)?.translate('attendance')??"",
                  ),
                  trailing: Icon(Icons.person)),
              Divider(),
              ListTile(
                onTap: () {
                  pushPage(
                      context,
                      SentMessagesScreen(
                        type: 2,
                      ));
                },
                title: Text(
                  AppLocalizations.of(context)?.translate('sentMessages')??"",
                ),
                trailing: Icon(Icons.message),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  pushPage(
                      context,
                      MessagesScreen(
                        type: 2,
                      ));
                },
                title: Text(
                  AppLocalizations.of(context)?.translate('messages')??"",
                ),
                trailing: Icon(Icons.message),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  pushPage(
                      context,
                      SendMessageStudentScreen(
                        type: 2,
                      ));
                },
                title: Text(
                  AppLocalizations.of(context)?.translate('sendMessage')??"",
                ),
                trailing: Icon(Icons.message_rounded),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  pushPage(
                      context,
                      RecommendationsListScreen(
                      ));
                },
                title: Text(
                    Localizations.localeOf(context).languageCode == "en"
                        ?"Recommendation Behavioural list":"قائمة التوصيات السلوكية",
                ),
                trailing: Icon(Icons.contact_page_rounded),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  pushPage(
                      context,
                      RecommendationAcademicListScreen(
                      ));
                },
                title: Text(
                    Localizations.localeOf(context).languageCode == "en"
                        ?"Recommendation academic list":"قائمة التوصيات الأكاديمية",
                ),
                trailing: Icon(Icons.contact_page_rounded),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  pushPage(
                      context,
                      PenaltiesListScreen(
                      ));
                },
                title: Text(
                    Localizations.localeOf(context).languageCode == "en"
                        ?"Conduct and penalties":"السلوك و الجزاءات",
                ),
                trailing: Icon(Icons.close),
              ),
            ])));
  }
}
