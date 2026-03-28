import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';

import '../../../Utils/memory.dart';
import '../../../models/notification_model.dart';
import 'package:intl/intl.dart';

import '../../../web_view/web_view_screen.dart';
import '../../loggedUser/homework/homeworks/homeworks_screen.dart';
import '../../parents/attendance/AttendanceScreen.dart';

import '../../parents/messages/sented_mesages/sented_messages_screen.dart';
import '../../teacher/homework/homeworks_list/homework_teacher_list_screen.dart';


class NotificationCell extends StatefulWidget {
  const NotificationCell({Key? key,  required this.notification, required this.press, }) : super(key: key);
  final NotificationModel? notification;
  final VoidCallback press;


  @override
  State<NotificationCell> createState() => _NotificationCellState();
}

class _NotificationCellState extends State<NotificationCell> {
  // This method formats the date and time of the notification based on whether it was sent today or on a previous day. If the notification was sent today, it returns the time in "HH:mm a" format; otherwise, it returns the date in "MMM dd" format.
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
  // This method checks if there is a notification and if it is of a specific type. If so, it removes the notification and navigates to the appropriate screen based on the user type.
  decideIfThereIsNotificationDetectOrNotAndItIsBehavior(String? type) async {
print(type);

    if(Get.find<StorageService>().checkThereIsNotificationOrNot) {
      switch (type) {
        case "msg":
          Get.find<StorageService>().removeNotification();
          {
       if ( Get.find<StorageService>().getUserType == "PARENTS") {
              Get.to(SentedMessagesScreen(),transition: Transition.rightToLeft,preventDuplicates: true);            }
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
            Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
                .find<StorageService>()
                .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);

          }
          break;
        case "report":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
                .find<StorageService>()
                .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
          }
          break;
        case "report2 ":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
                .find<StorageService>()
                .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
          }
          break;
        case "penalty":
          {
            Get.find<StorageService>().removeNotification();
            Get.to(()=>WebViewContainer("https://alrayyanprivateschools.com/parent/login.php?parent_id=${Get
                .find<StorageService>()
                .getId}"),transition: Transition.rightToLeft,preventDuplicates: true);
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