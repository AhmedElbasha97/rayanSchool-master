import 'package:flutter/material.dart';
import 'package:rayanSchool/views/homeScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/commonStyles.dart';
import '../../globals/helpers.dart';
import '../../globals/widgets/loader.dart';
import '../../globals/widgets/notification_icon.dart';
import '../../models/notification_model.dart';
import '../../services/notification.dart';
import 'notifiication_details_screen.dart';
import 'widget/notifiction_cell.dart';

class NotificationsListScreen extends StatefulWidget {
  const NotificationsListScreen({Key? key}) : super(key: key);

  @override
  _NotificationsListScreenState createState() => _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  bool isLoading = true;
  var type ;
   List<NotificationModel>? userNotificationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     getAllListOfNotification();
  }
  getAllListOfNotification()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString("type");
    var userList = await NotificationServices().listAllNotification();
    userNotificationList = userList;
    print(userNotificationList);

    print("hi lenth");
    isLoading=false;
    setState(() {

    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          Localizations.localeOf(context).languageCode == "en"
              ?"Notification list":"قائمة الإشعارات",
          style: TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColor,
          ),
          onPressed: () { Navigator.of(context).pop();

            },
        ),
      ),
      body: isLoading?Loader(): userNotificationList?.isEmpty??true?
      Container(
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/notification_holder.png"),
            ),
            SizedBox(height: 20,),
            Text(Localizations.localeOf(context).languageCode == "en"
                ?"no Notification available":"لا يوجد إشعارات متوفرة الآن",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ):ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: userNotificationList?.length,
          itemBuilder: (context, int index) {
            return NotificationCell(press: () {   pushPage(context, NotifiicationDetailsScreen(notification:userNotificationList?[index] ,)); },notification: userNotificationList?[index],);
          }),
    );
  }
}