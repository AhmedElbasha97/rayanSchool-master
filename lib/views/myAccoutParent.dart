import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/loggedUser/Messages/sendMessageStudent.dart';
import 'package:rayanSchool/views/parents/AttendanceScreen.dart';
import 'package:rayanSchool/views/parents/ReportsScreen.dart';

import 'loggedUser/Messages/MessagesScreen.dart';
import 'loggedUser/Messages/sentMessageScreen.dart';

class MyAccountParent extends StatefulWidget {
  @override
  _MyAccountParentState createState() => _MyAccountParentState();
}

class _MyAccountParentState extends State<MyAccountParent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
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
            ])));
  }
}
