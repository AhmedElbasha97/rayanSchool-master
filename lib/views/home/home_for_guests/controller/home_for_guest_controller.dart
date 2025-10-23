import 'package:get/get.dart';

import '../../../../Utils/memory.dart';
import '../../../../models/school_social_media_link_model.dart';
import '../../../../services/appInfoService.dart';
import '../../../loggedUser/Messages/messages/messages_screen.dart';
import '../../../loggedUser/homework/homeworks/homeworks_screen.dart';
import '../../../parents/attendance/AttendanceScreen.dart';
import '../../../parents/panalties/penalties_list_screen.dart';
import '../../../parents/recommendation_academic/recommendation_academic_list_screen.dart';
import '../../../parents/recommendation_list/recommendation_list_screen.dart';
import '../../../parents/report/reports/ReportsScreen.dart';
import '../../../teacher/homework/homeworks_list/homework_teacher_list_screen.dart';
import '../../../teacher/messages/received_messages/received_message_screen.dart';

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
  Future<void> getHomeData() async {
    dataLink.value = await AppInfoService().getSchoolSocialMediaLink();
    isLoading.value = false;
  }
}