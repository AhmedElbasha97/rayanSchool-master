import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/views/Student/books/bookScreen.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../globals/commonStyles.dart';
import '../../../web_view/web_view_screen.dart';
import '../../loggedUser/homework/homeworks/homeworks_screen.dart';


class MyAccount extends StatelessWidget {
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
            // ListTile for Homework with navigation to HomeWorkScreen
            ListTile(
              onTap: () {
                Get.to(HomeWorkScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
              },
              title: Text(
                homeWorks.tr,
              ),
              trailing: Icon(Icons.book),
            ),
            Divider(),
            // ListTile for Books with navigation to BooksScreen
            ListTile(
              onTap: () {
                Get.to(BooksScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
                },
              title: Text(
                booksnref.tr,
              ),
              trailing: Icon(Icons.book),
            ),
            Divider(),
            // ListTile for Schedule with navigation to WebViewContainer showing the schedule page
            ListTile(
                onTap: () async {
                  Get.to(WebViewContainer("https://alrayyanprivateschools.com/student_table_design.php?student_id=${Get
                      .find<StorageService>()
                      .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
                },
                title: Text(
                  schedule.tr,
                ),
                trailing: Icon(Icons.timer)),
            Divider(),
          ],
        ),
      ),
    );
  }
}
