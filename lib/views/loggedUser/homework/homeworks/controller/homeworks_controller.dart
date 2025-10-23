import 'package:get/get.dart';
import 'package:rayanSchool/models/homeWork.dart';
import 'package:rayanSchool/services/loggedUser.dart';

import '../../../../../Utils/memory.dart';

class HomeWorkController extends GetxController {
  var isLoading = true.obs;
  var homeworks = <HomeWork>[].obs;

  Future<void> fetchHomeworks() async {
    isLoading.value = true;

    homeworks.value = await LoggedUser().getHomeWorks(id:  Get.find<StorageService>().getId ?? "");
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchHomeworks();
  }
}
