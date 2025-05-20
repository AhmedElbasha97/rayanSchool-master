import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/notification_model.dart';
import 'package:intl/intl.dart';

import '../../loggedUser/Messages/MessagesScreen.dart';
import '../../loggedUser/homeWork.dart';
import '../../parents/AttendanceScreen.dart';
import '../../parents/ReportsScreen.dart';
import '../../parents/penalties_list_screen.dart';
import '../../parents/recommendation_academic_list_screen.dart';
import '../../parents/recommendation_list_screen.dart';
import '../../teacher/homework_teacher_list_screen.dart';
import '../../teacher/messages/receidvedMessageScreen.dart';

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

      switch (type) {
        case "msg":

          {
            if (prefs.getString("type") == "STUDENT") {
              pushPage(
                  context,
                  MessagesScreen(
                  ));
            } else if (prefs.getString("type") == "TEACHER") {
              pushPage(
                  context,
                  ReceivedMessageScreen(
                  ));
            } else if (prefs.getString("type") == "PARENTS") {
              pushPage(
                  context,
                  MessagesScreen(
                    type: 2,
                  ));
            }
          }
          break;
        case "absence":
          {
            pushPage(context, AttendanceScreen());
          }
          break;
        case "report1":
          {

            pushPage(
                context,
                RecommendationAcademicListScreen(
                ));
          }
          break;
        case "report":
          {

            pushPage(
                context,
                ReportScreen(
                ));
          }
          break;
        case "report2":
          {
            pushPage(
                context,
                RecommendationsListScreen(
                ));
          }
          break;
        case "penalty":
          {
            pushPage(
                context,
                PenaltiesListScreen(
                ));
          }
          break;
        case "homework":
          {

            if (prefs.getString("type") == "STUDENT") {
              pushPage(
                  context,
                  HomeWorkScreen(
                  ));
            } else if (prefs.getString("type") == "TEACHER") {
              pushPage(
                  context,
                  HomeworkTeacherListScreen(
                  ));
            }
          }
          break;
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