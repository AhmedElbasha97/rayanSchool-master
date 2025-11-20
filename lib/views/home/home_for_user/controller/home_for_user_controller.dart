import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/photoAlbum.dart';
import 'package:rayanSchool/models/AppInfo/sliderPhotos.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';
import 'package:rayanSchool/models/school_social_media_link_model.dart';
import 'package:rayanSchool/services/albums.dart';
import 'package:rayanSchool/services/appInfoService.dart';

import '../../../../Utils/memory.dart';
import '../../../../web_view/web_view_screen.dart';
import '../../../loggedUser/homework/homeworks/homeworks_screen.dart';
import '../../../parents/attendance/AttendanceScreen.dart';
import '../../../parents/messages/sented_mesages/sented_messages_screen.dart';
import '../../../teacher/homework/homeworks_list/homework_teacher_list_screen.dart';


class HomeForUserController extends GetxController {
  // Reactive variables
  var sliderData = <SliderData>[].obs;
  var photoAlbums = <PhotoAlbum>[].obs;
  var videoAlbums = <Videos>[].obs;
  var isLoading = true.obs;
  var dataLink = Rxn<SchoolSocialMediaLinkModel>();

  @override
  void onInit() {
    super.onInit();
    checkNotifications();
    getHomeData();
  }

  /// Check if app opened from notification & navigate accordingly
  Future<void> checkNotifications() async {
    var type= Get.find<StorageService>().getNotificationRoute;
    if(Get.find<StorageService>().checkThereIsNotificationOrNot) {
      switch (type) {
        case "msg":
          Get.find<StorageService>().removeNotification();
          {
        if ( Get.find<StorageService>().getUserType == "PARENTS") {
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

  /// Fetch data based on login state
  Future<void> getHomeData() async {
      sliderData.value = await AppInfoService().getSliderPhotos();
    await getAlbums();
    isLoading.value = false;
  }

  /// Fetch photo & video albums
  Future<void> getAlbums() async {
    photoAlbums.value = await AlbumsService().getphotoAlbums() ?? [];
    videoAlbums.value = await AlbumsService().getVideoAlbums() ?? [];
  }
}
