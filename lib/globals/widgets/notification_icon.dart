import 'package:flutter/material.dart';

import 'package:rayanSchool/globals/commonStyles.dart';

import '../../models/notification_counter_model.dart';
import '../../services/notification.dart';
import '../../views/Notification/notification_list.dart';
import '../helpers.dart';

class NotificationIcon extends StatefulWidget {
   NotificationIcon({super.key});

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  int counter = 0;
  getData() async {
    NotificationCounterModel? data = await NotificationServices().counterNotification();
    counter = data?.count??0;
    setState(() {

    });

  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
        ),
        Positioned(
          right: 5,
          top: 5,
          child: IconButton(icon:  Icon(Icons.notifications_none,color: mainColor,size: 35), onPressed: () {

            pushPage(context,NotificationsListScreen());

          }),
        ),
        counter != 0 ?  Positioned(
          right: 11,
          top:13,
          child:  Container(
            padding: const EdgeInsets.all(2),
            decoration:  BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 14,
              minHeight: 14,
            ),
            child: Text(
              '$counter',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ) :  Container()
      ],
    );
  }
}
