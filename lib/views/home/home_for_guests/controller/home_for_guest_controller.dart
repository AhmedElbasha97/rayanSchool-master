import 'package:get/get.dart';

import '../../../../Utils/memory.dart';
import '../../../../models/school_social_media_link_model.dart';
import '../../../../services/appInfoService.dart';
import '../../../loggedUser/homework/homeworks/homeworks_screen.dart';
import '../../../parents/attendance/AttendanceScreen.dart';
import '../../../parents/messages/sented_mesages/sented_messages_screen.dart';

import '../../../teacher/homework/homeworks_list/homework_teacher_list_screen.dart';

class HomeForGuestController extends GetxController{
  var isLoading = true.obs;
  var dataLink = Rxn<SchoolSocialMediaLinkModel>();

  @override
  void onInit() {
    super.onInit();
    checkNotifications();
    getHomeData();
  }
  Future<void> checkNotifications() async {
    var type= Get.find<StorageService>().getNotificationRoute;
    if(Get.find<StorageService>().checkThereIsNotificationOrNot) {
      switch (type) {
        case "msg":
          Get.find<StorageService>().removeNotification();
          {
            if ( Get.find<StorageService>().getUserType == "STUDENT") {

            } else if ( Get.find<StorageService>().getUserType == "TEACHER") {

            } else if ( Get.find<StorageService>().getUserType == "PARENTS") {
              Get.to(SentedMessagesScreen(),transition: Transition.rightToLeft,preventDuplicates: true);
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

          }
          break;
        case "report":
          {
            Get.find<StorageService>().removeNotification();
          }
          break;
        case "report2 ":
          {
            Get.find<StorageService>().removeNotification();
          }
          break;
        case "penalty":
          {
            Get.find<StorageService>().removeNotification();
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
  Future<void> getHomeData() async {
    dataLink.value = await AppInfoService().getSchoolSocialMediaLink();
    isLoading.value = false;
  }
}