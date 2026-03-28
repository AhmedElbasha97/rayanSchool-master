// views/notifications_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/globals/commonStyles.dart';


import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../home/home_for_user/home_for_user_screen.dart';
import '../notifiication_details_screen.dart';
import '../widget/notifiction_cell.dart';
import 'controller/notification_list_controller.dart';

class NotificationsListScreen extends StatelessWidget {
  const NotificationsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController(), permanent: false);

    return Scaffold(
      // AppBar with logo and custom colors
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Text(
          Get.find<StorageService>().activeLocale ==
              SupportedLocales.english
              ? "Notification list"
              : "قائمة الإشعارات",
          style: TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: mainColor),
          onPressed: () {
            Get.to(()=>HomeLoggedInScreen(),transition: Transition.rightToLeft,preventDuplicates: true);


          },
        ),
      ),
      body: Obx(() {
        // Display a loading indicator while data is being fetched
        if (controller.isLoading.value) return const Loader();

        // Display an empty state if there are no notifications available
        if (controller.notifications?.isEmpty??true) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (_, __) =>             Get.to(()=>HomeLoggedInScreen(),transition: Transition.rightToLeft,preventDuplicates: true)
            ,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset("assets/images/notification_holder.png"),
                  const SizedBox(height: 20),
                  Text(
                    Get.find<StorageService>().activeLocale ==
                        SupportedLocales.english
                        ? "no Notification available"
                        : "لا يوجد إشعارات متوفرة الآن",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        }
        // Display the notifications list using ListView.builder and NotificationCell widget
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (_, __) => Get.off(() =>  HomeLoggedInScreen()),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.notifications?.length,
            itemBuilder: (context, index) {
              final item = controller.notifications?[index];
              return NotificationCell(
                notification: item,
                press: () {
                  Get.to(()=>NotifiicationDetailsScreen(notification: item),transition: Transition.rightToLeft,preventDuplicates: true);
                  }
              );
            },
          ),
        );
      }),
    );
  }
}
