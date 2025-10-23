import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/views/parents/attendance/AttendanceScreen.dart';
import 'package:rayanSchool/views/parents/report/reports/ReportsScreen.dart';
import 'package:rayanSchool/views/parents/panalties/penalties_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_academic/recommendation_academic_list_screen.dart';
import 'package:rayanSchool/views/parents/recommendation_list/recommendation_list_screen.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Utils/translation_key.dart';
import '../../../Widgets/loader.dart';
import '../../../globals/commonStyles.dart';
import '../../../models/parents/child_model.dart';
import '../../loggedUser/Messages/messages/messages_screen.dart';
import '../../loggedUser/Messages/send_message_student/send_message_student_screen.dart';
import '../../loggedUser/Messages/sent_messages/sent_message_screen.dart';
import '../../parents/messages/sent_message_parent/sent_mesage_screen.dart';
import 'controller/my_account_parent_controller.dart';

class MyAccountParent extends StatelessWidget {
  const MyAccountParent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyAccountParentController(), permanent: false);

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader(
            height: MediaQuery.of(context).size.height,
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Obx(() =>  PopupMenuButton<ChildModel>(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.45,
                    minWidth: Get.width * 0.45,
                  ),
                  itemBuilder: (context) => controller.childData.map((e) {
                    return PopupMenuItem(
                      value: e,
                      textStyle: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w700,
                      ),
                      onTap: () {
                        controller.selectChild(e);
                      },
                      child: SizedBox(
                        width: Get.width * 0.45,
                        child: Column(
                          children: [
                            Text(
                              e.name ?? "",
                              style: TextStyle(
                                color: mainTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            e == controller.childData.last
                                ? const SizedBox()
                                : Divider(
                              color: mainColor,
                              height: 1,
                              thickness: 1,
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
                        minHeight: Get.height * 0.06,
                      ),
                      width: Get.width * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mainColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  'الطالب المختار: ${controller.chosenChild.value}',
                                  style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: const Offset(0.5, 0.5),
                                        blurRadius: 0.5,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                    fontSize: 15,
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
              ),
              ListTile(
                onTap: () {
                  Get.to(ReportScreen(),transition: Transition.rightToLeft,preventDuplicates: true);


                },
                title: Text(
                  reports.tr,
                ),
                trailing: Icon(Icons.book),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Get.to(AttendanceScreen(),transition: Transition.rightToLeft,preventDuplicates: true);


                },
                title: Text(
                  attendance.tr,
                ),
                trailing: Icon(Icons.person),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Get.to(SentMessagesScreen(type: 2),transition: Transition.rightToLeft,preventDuplicates: true);
                },
                title: Text(
                  sentMessages.tr,
                ),
                trailing: Icon(Icons.message),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Get.to(MessagesScreen(type: 2),transition: Transition.rightToLeft,preventDuplicates: true);
                },
                title: Text(
                  messages.tr,
                ),
                trailing: Icon(Icons.message),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Get.to(SentMessageParentScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                title: Text(
                  sendMessage.tr,
                ),
                trailing: Icon(Icons.message_rounded),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Get.to(RecommendationsListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                title: Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "Recommendation Behavioural list"
                      : "قائمة التوصيات السلوكية",
                ),
                trailing: Icon(Icons.contact_page_rounded),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Get.to(RecommendationAcademicListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
                },
                title: Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "Recommendation academic list"
                      : "قائمة التوصيات الأكاديمية",
                ),
                trailing: Icon(Icons.contact_page_rounded),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  Get.to(PenaltiesListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                title: Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "Conduct and penalties"
                      : "السلوك والجزاءات",
                ),
                trailing: Icon(Icons.close),
              ),
            ],
          ),
        );
      }),
    );
  }
}
