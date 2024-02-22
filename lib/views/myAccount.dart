import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/Student/AskedQuestion.dart';
import 'package:rayanSchool/views/Student/bookScreen.dart';
import 'package:rayanSchool/views/loggedUser/Messages/MessagesScreen.dart';
import 'package:rayanSchool/views/loggedUser/Messages/sendMessageStudent.dart';
import 'package:rayanSchool/views/loggedUser/Messages/sentMessageScreen.dart';
import 'package:rayanSchool/views/loggedUser/homeWork.dart';
import 'package:rayanSchool/views/loggedUser/importantFilesScreen.dart';
import 'package:rayanSchool/views/loggedUser/questionBank.dart';

import 'loggedUser/fileScreen.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
                pushPage(context, HomeWorkScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('homeWorks'),
              ),
              trailing: Icon(Icons.book),
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
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, FilesScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('files'),
              ),
              trailing: Icon(Icons.file_present),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, FilesImportantScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('impProg'),
              ),
              trailing: Icon(Icons.file_present),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SendMessageStudentScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('sendMessage'),
              ),
              trailing: Icon(Icons.message_rounded),
            ),
            Divider(),
            ListTile(
              onTap: () {},
              title: Text(
                AppLocalizations.of(context).translate('results'),
              ),
              trailing: Icon(Icons.check_box),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, AskedQuestions());
              },
              title: Text(
                AppLocalizations.of(context).translate('questionsStudent'),
              ),
              trailing: Icon(Icons.help_center),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, BooksScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('booksnref'),
              ),
              trailing: Icon(Icons.book),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, MessagesScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('messages'),
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                pushPage(context, SentMessagesScreen());
              },
              title: Text(
                AppLocalizations.of(context).translate('sentMessages'),
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
                onTap: () {},
                title: Text(
                  AppLocalizations.of(context).translate('schedule'),
                ),
                trailing: Icon(Icons.timer)),
            Divider(),
          ],
        ),
      ),
    );
  }
}
