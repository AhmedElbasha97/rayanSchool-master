import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/teacher/add_home_work_screen.dart';
import 'package:rayanSchool/views/teacher/homework_teacher_list_screen.dart';
import 'package:rayanSchool/views/teacher/messages/MessagesScreen.dart';
import 'package:rayanSchool/views/teacher/messages/receidvedMessageScreen.dart';
import 'package:rayanSchool/views/teacher/messages/sendMessageTeacher.dart';
import 'package:rayanSchool/views/teacher/questionBank.dart';
import 'package:rayanSchool/views/teacher/reportsScreen.dart';
import 'package:rayanSchool/views/teacher/scheduleScreen.dart';
import 'package:rayanSchool/views/teacher/sendReport.dart';
import 'package:rayanSchool/views/teacher/sent_recommendation_accadmic_screen.dart';
import 'package:rayanSchool/views/teacher/sent_recommendations_screen.dart';

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
                AppLocalizations.of(context)?.translate('reports')??"",
              ),
              trailing: Icon(Icons.book),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SendReport());
              },
              title: Text(
                AppLocalizations.of(context)?.translate('sendReport')??"",
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
                onTap: () {
                  pushPage(context, TeacherSchedule());
                },
                title: Text(
                  AppLocalizations.of(context)?.translate('schedule')??"",
                ),
                trailing: Icon(Icons.timer)),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(
                    context,
                    ReceivedMessageScreen(
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
                pushPage(context, MessagesTeacherScreen());
              },
              title: Text(
                AppLocalizations.of(context)?.translate('sentMessages')??"",
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, HomeworkTeacherListScreen());
              },
              title: Text(
                AppLocalizations.of(context)?.translate('homeWorks')??"",
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, AddHomeWorkScreen());
              },
              title: Text(
                Localizations.localeOf(context).languageCode == "en"
                    ?"add new homework":"إضافة واجب مدرسي جديد",
              ),
              trailing: Icon(Icons.contact_page_rounded),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, QuestionBankScreen());
              },
              title: Text(
                AppLocalizations.of(context)?.translate('questionsBank')??"",
              ),
              trailing: Icon(Icons.help),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SendRecommendationsScreens());
              },
              title: Text(
                Localizations.localeOf(context).languageCode == "en"
                    ?"Send a Behavioural recommendation":"إرسال توصية السلوكية",
              ),
              trailing: Icon(Icons.contact_page_rounded),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SentRecommendationAccadmicScreen());
              },
              title: Text(
                Localizations.localeOf(context).languageCode == "en"
                    ?"Send a academic recommendation":"إرسال توصية الأكاديمية",
              ),
              trailing: Icon(Icons.contact_page_rounded),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SendMessageTeacherScreen());
              },
              title: Text(
                Localizations.localeOf(context).languageCode == "en"
                    ?"Send a message":"إرسال رسالة",
              ),
              trailing: Icon(Icons.contact_page_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
