import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/memory.dart';
import '../../../models/notification_model.dart';
import 'package:intl/intl.dart';

import '../../loggedUser/Messages/messages/messages_screen.dart';
import '../../loggedUser/homework/homeworks/homeworks_screen.dart';
import '../../parents/attendance/AttendanceScreen.dart';
import '../../parents/report/reports/ReportsScreen.dart';
import '../../parents/panalties/penalties_list_screen.dart';
import '../../parents/recommendation_academic/recommendation_academic_list_screen.dart';
import '../../parents/recommendation_list/recommendation_list_screen.dart';
import '../../teacher/homework/homeworks_list/homework_teacher_list_screen.dart';
import '../../teacher/messages/received_messages/received_message_screen.dart';

class NotificationCell extends StatefulWidget {
  const NotificationCell({Key? key,  required this.notification, required this.press, }) : super(key: key);
  final NotificationModel? notification;
  final VoidCallback press;


  @override
  State<NotificationCell> createState() => _NotificationCellState();
}

class _NotificationCellState extends State<NotificationCell> {
  String returnDateAndTime(NotificationModel? chat){
    String dateOrTime = "" ;
    print(chat?.date??"");
    final format = DateFormat('HH:mm a');
    DateFormat formatDate = DateFormat("MMM dd");

    final dateTime = DateTime.parse(chat?.date??"2024-02-28 11:55:54");
    if(dateTime.day == DateTime.now().day){
      dateOrTime = format.format(dateTime);
    }else{
      dateOrTime = formatDate.format(dateTime);
    }
    return dateOrTime;
  }
  decideIfThereIsNotificationDetectOrNotAndItIsBehavior(String? type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
print(type);

    if(Get.find<StorageService>().checkThereIsNotificationOrNot) {
      switch (type) {
        case "msg":
          Get.find<StorageService>().removeNotification();
          {
            if ( Get.find<StorageService>().getUserType == "STUDENT") {
              Get.to(()=>MessagesScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

            } else if ( Get.find<StorageService>().getUserType == "TEACHER") {
              Get.to(()=>ReceivedMessageScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

            } else if ( Get.find<StorageService>().getUserType == "PARENTS") {
              Get.to(()=>MessagesScreen(type: 2,),transition: Transition.rightToLeft,preventDuplicates: true);
            }
          }
          break;
        case "absence":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=>AttendanceScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

          }
          break;
        case "report1":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=>RecommendationAcademicListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);

          }
          break;
        case "report":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=> ReportScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
          }
          break;
        case "report2 ":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=> RecommendationsListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
          }
          break;
        case "penalty":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=> PenaltiesListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
          }
          break;
        case "homework":
          {
            Get.find<StorageService>().removeNotification();
            if ( Get.find<StorageService>().getUserType == "STUDENT") {
              Get.to(()=>HomeWorkScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
            } else if ( Get.find<StorageService>().getUserType == "TEACHER") {
              Get.to(()=>HomeworkTeacherListScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
            }
          }
          break;
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: widget.press,
      child: Container(
        width: double.infinity,
        child:  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
               backgroundColor: Colors.grey,
               child: Icon(
                 Icons.notification_important,color: Colors.black,
               ),
              ),
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.notification?.title??"",
                        style:
                        TextStyle(fontSize: 16, fontWeight: (widget.notification?.view) == "1"?FontWeight.normal:FontWeight.bold ),
                        maxLines: null,
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.notification?.text??"",
                        style:
                        TextStyle(fontSize: 16, fontWeight: (widget.notification?.view) == "1"?FontWeight.normal:FontWeight.bold ),
                        maxLines: null,
                      ),
                      SizedBox(height: 8),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          returnDateAndTime(widget.notification),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: (widget.notification?.view) == "1"?FontWeight.normal:FontWeight
                            .bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      widget.notification?.page=="login"?SizedBox():InkWell(
                        onTap: (){
                          decideIfThereIsNotificationDetectOrNotAndItIsBehavior(widget.notification?.page??"");
                        },
                        child: Text(
                          Localizations.localeOf(context).languageCode == "en"
                              ?"open Notification":"فتح الأشعار",
                          style:
                          TextStyle(fontSize: 16, fontWeight: (widget.notification?.view) == "1"?FontWeight.normal:FontWeight.bold,color: mainColor ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade500,width: 1)
            )
        ),

      ),
    );
  }
}