import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';
import 'package:intl/intl.dart';

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