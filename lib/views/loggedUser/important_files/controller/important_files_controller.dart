import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/models/importantFiles.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Utils/memory.dart';

class FilesImportantController extends GetxController {
  var isLoading = true.obs;
  var files = <ImportantFile>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFiles();
  }
  sendClick(String link,BuildContext context) async {
    Uri uri = Uri.parse(link);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      showAlert(context);
    }
  }
  // Alert dialog to show when the link cannot be opened
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
  // Fetch important files for the logged-in user
  Future<void> fetchFiles() async {
    isLoading.value = true;

    files.value = await LoggedUser().getImportantFiles(id:  Get.find<StorageService>().getId);
    isLoading.value = false;
  }
}
