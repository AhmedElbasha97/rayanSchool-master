import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/views/teacher/homework/add_home_work/add_home_work_screen.dart';
import 'package:rayanSchool/views/teacher/homework/homeworks_list/homework_teacher_list_screen.dart';
import 'package:rayanSchool/views/teacher/messages/messages/messages_screen.dart';
import 'package:rayanSchool/views/teacher/messages/received_messages/received_message_screen.dart';
import 'package:rayanSchool/views/teacher/messages/send_messages/send_message_teacher_screen.dart';
import 'package:rayanSchool/views/teacher/question_bank/question_bank_screen.dart';
import 'package:rayanSchool/views/teacher/report/reports/reports_screen.dart';
import 'package:rayanSchool/views/teacher/scheduleScreen.dart';
import 'package:rayanSchool/views/teacher/report/send_report/send_report_screen.dart';
import 'package:rayanSchool/views/teacher/recommendation/recommendation%20accadimic/sent_recommendation_accadmic_screen.dart';
import 'package:rayanSchool/views/teacher/recommendation/behavior_recommendation/sent_recommendations_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../globals/commonStyles.dart';
import '../../../web_view/web_view_screen.dart';

class MyAccountTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        iconTheme: new IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [

            ListTile(
              onTap: () {
                Get.to(()=>ReportScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
              },
              title: Text(
                reports.tr,
              ),
              trailing: Icon(Icons.book),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>SendReport(),transition: Transition.rightToLeft,preventDuplicates: true);
                },
              title: Text(
                sendReport.tr,
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
                onTap: () async {
                  Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/teacher_table_design.php?teacher_id=${Get
                      .find<StorageService>()
                      .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                title: Text(schedule.tr,
                ),
                trailing: Icon(Icons.timer)),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>ReceivedMessageScreen(
                ),transition: Transition.rightToLeft,preventDuplicates: true);


              },
              title: Text(
               messages.tr,
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>MessagesTeacherScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
              },
              title: Text(
                sentMessages.tr,
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>HomeworkTeacherListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
                },
              title: Text(
                homeWorks.tr,
              ),
              trailing: Icon(Icons.message),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>AddHomeWorkScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
                },
              title: Text(
                Get.find<StorageService>().activeLocale ==
                    SupportedLocales.english
                    ?"add new homework":"إضافة واجب مدرسي جديد",
              ),
              trailing: Icon(Icons.contact_page_rounded),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>QuestionBankScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
                },
              title: Text(
                questionsBank.tr,
              ),
              trailing: Icon(Icons.help),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>SendRecommendationsScreens(),transition: Transition.rightToLeft,preventDuplicates: true,);
              },
              title: Text(
                Get.find<StorageService>().activeLocale ==
                    SupportedLocales.english
                    ?"Send a Behavioural recommendation":"إرسال توصية السلوكية",
              ),
              trailing: Icon(Icons.contact_page_rounded),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>SentRecommendationAccadmicScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
                },
              title: Text(
                Get.find<StorageService>().activeLocale ==
                    SupportedLocales.english
                    ?"Send a academic recommendation":"إرسال توصية الأكاديمية",
              ),
              trailing: Icon(Icons.contact_page_rounded),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Get.to(()=>SendMessageTeacherScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

              },
              title: Text(
                Get.find<StorageService>().activeLocale ==
                    SupportedLocales.english
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
