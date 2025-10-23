import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rayanSchool/models/files.dart';
import 'package:rayanSchool/services/loggedUser.dart';

import '../../../../../Utils/memory.dart';

class FilesController extends GetxController {
  var isLoading = true.obs;
   RxList<Files>? files = <Files>[].obs;

  Future<void> fetchFiles() async {
    isLoading.value = true;

    files?.value = await LoggedUser().getFiles(id: Get.find<StorageService>().getId)??[];
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchFiles();
  }
}