// controllers/notifications_controller.dart
import 'package:get/get.dart';
import 'package:rayanSchool/models/notification_model.dart';
import 'package:rayanSchool/services/notification.dart';
import '../../../../Utils/memory.dart';

class NotificationsController extends GetxController {
  final isLoading = true.obs;
  final  RxList<NotificationModel>? notifications = <NotificationModel>[].obs;
  final type = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {

      type.value = Get.find<StorageService>().getUserType;

      final userList = await NotificationServices().listAllNotification();
      notifications?.assignAll(userList??<NotificationModel>[]);
    } finally {
      isLoading.value = false;
    }
  }
}
