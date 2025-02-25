import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../globals/commonStyles.dart';
import '../../models/notification_model.dart';

class NotifiicationDetailsScreen extends StatelessWidget {
  const NotifiicationDetailsScreen({Key? key, this.notification}) : super(key: key);
  final NotificationModel? notification;
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
    return  Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          Localizations.localeOf(context).languageCode == "en"
              ?"Notification Details":"تفاصيل الأشعار",
          style: TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
        body:Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: mainColor,width: 1),
                          shape: BoxShape.circle
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainTextColor,width: 1),
                            shape: BoxShape.circle
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.notification_important,color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text( notification?.title??"",
                            style: const TextStyle(

                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 15),),
                          Text(
                            returnDateAndTime(notification),

                            style: const TextStyle(

                                color: Colors.grey,
                                fontWeight: FontWeight.w800,
                                fontSize: 15),
                            maxLines: null,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  border:  Border.all(color: mainColor,width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: mainTextColor,width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(notification?.text??"",
                      style: const TextStyle(

                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 15),
                      maxLines: null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
