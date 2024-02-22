import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/teacher/messages/MessagesScreen.dart';
import 'package:rayanSchool/views/teacher/questionBank.dart';
import 'package:rayanSchool/views/teacher/reportsScreen.dart';
import 'package:rayanSchool/views/teacher/scheduleScreen.dart';
import 'package:rayanSchool/views/teacher/sendReport.dart';

class MyAccountTeacher extends StatefulWidget {
  @override
  _MyAccountTeacherState createState() => _MyAccountTeacherState();
}

class _MyAccountTeacherState extends State<MyAccountTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                pushPage(context, ReportScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('reports'),
              ),
              trailing: Icon(Icons.book),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SendReport());
              },
              title: Text(
                AppLocalizations.of(context).translate('sendReport'),
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
                onTap: () {
                  pushPage(context, TeacherSchedule());
                },
                title: Text(
                  AppLocalizations.of(context).translate('schedule'),
                ),
                trailing: Icon(Icons.timer)),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, MessagesScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('sentMessages'),
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SendReport());
              },
              title: Text(
                AppLocalizations.of(context).translate('homeWorks'),
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, QuestionBankScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('questionsBank'),
              ),
              trailing: Icon(Icons.help),
            ),
          ],
        ),
      ),
    );
  }
}
