import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/models/FilesDetails.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../Utils/memory.dart';

class FileDetailsController extends GetxController {
  // Observables
  var isLoading = true.obs;
  var files = <FileDetails>[].obs;
  final String id;
  // Constructor
  FileDetailsController(this.id);
  @override
  void onInit() {
    super.onInit();
    getFilesDetails();
  }
  // Fetch data
  Future<void> getFilesDetails() async {
    isLoading.value = true;
    files.value = await LoggedUser().getFilesDetails(id: Get.find<StorageService>().getId, fileID: id);
    isLoading.value = false;
  }
  // Open file link
  sendClick(String link,BuildContext context) async {
    Uri uri = Uri.parse(link);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    showAlert(context);
    }
  }
  // Show alert dialog
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تنبيه"),
        content: const Text("لا يمكن فتح الرابط"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("موافق"),
          ),
        ],
      ),
    );
  }

}