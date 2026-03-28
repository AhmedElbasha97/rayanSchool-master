import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rayanSchool/views/teacher/homework/add_home_work/add_home_work_screen.dart';
import 'package:rayanSchool/views/teacher/homework/homeworks_list/homework_teacher_list_screen.dart';


import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../globals/commonStyles.dart';
import '../../../web_view/web_view_screen.dart';

class MyAccountTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with logo and custom colors
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
            // ListTile for Reports with navigation to WebViewContainer showing the reports page
            ListTile(
              onTap: () {
                Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/teacher/login.php?teacher_id=${Get
                    .find<StorageService>()
                    .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
              },
              title: Text(
                reports.tr,
              ),
              trailing: Icon(Icons.book),
            ),

            Divider(),
            // ListTile for Schedule with navigation to WebViewContainer showing the schedule page
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
            // ListTile for Homework with navigation to HomeworkTeacherListScreen
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
            // ListTile for Add Homework with navigation to AddHomeWorkScreen
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



          ],
        ),
      ),
    );
  }
}
