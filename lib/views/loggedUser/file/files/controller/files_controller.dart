import 'package:get/get.dart';
import 'package:rayanSchool/models/files.dart';
import 'package:rayanSchool/services/loggedUser.dart';

import '../../../../../Utils/memory.dart';

class FilesController extends GetxController {
  // Observables
  var isLoading = true.obs;
   RxList<Files>? files = <Files>[].obs;
   // Fetch data
  @override
  void onInit() {
    super.onInit();
    fetchFiles();
  }
  // Fetch data
  Future<void> fetchFiles() async {
    isLoading.value = true;

    files?.value = await LoggedUser().getFiles(id: Get.find<StorageService>().getId)??[];
    isLoading.value = false;
  }


}