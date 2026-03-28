// lib/controllers/home_work_details_controller.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rayanSchool/models/homeWorkDetails.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:rayanSchool/services/teachersService.dart';
import '../../../../../Utils/memory.dart';

class HomeWorkDetailsController extends GetxController {

  final String homeWorkId;
  HomeWorkDetailsController(this.homeWorkId);
  // Observables
  var isLoading = true.obs;
  var isDownloading = false.obs;
  var isFileDownloaded = false.obs;
  var homeworks = <HomeWorkDetails>[].obs;
  String? lastSavedFilePath;
  // Initialize data fetching when the controller is created
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
// Fetch data based on user type and update the loading state accordingly
  Future<void> fetchData() async {
    isLoading.value = true;

    if ( Get.find<StorageService>().getUserType == "STUDENT") {
      homeworks.value =
      await LoggedUser().gethomeWorkDetails(id:  Get.find<StorageService>().getId, homeWorkId: homeWorkId);
    } else {
      homeworks.value = await TeacherService()
          .gethomeWorkTeacherDetails(id:  Get.find<StorageService>().getId, homeWorkId: homeWorkId);
    }
    await checkIfFileExists();
    isLoading.value = false;
  }
// Check if the file exists at the last saved path and update the observable accordingly
  Future<void> checkIfFileExists() async {
    if (lastSavedFilePath == null) {
      isFileDownloaded.value = false;
      return;
    }
    isFileDownloaded.value = await File(lastSavedFilePath!).exists();
  }
// Save the file and update the observable accordingly
  Future<bool> saveFile(context) async {
    if (homeworks.isEmpty) return false;
    final fileUrl = homeworks.first.homeworkFile;
    if (fileUrl == null || fileUrl.isEmpty) return false;

    await hasAcceptedPermissions();
    isDownloading.value = true;

    try {
      final fileName = fileUrl.split('/').last;
      final res = await Dio().get<List<int>>(
        fileUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final saved = await FileSaver.instance.saveFile(
        name: fileName, // ✅ include extension directly
        bytes: Uint8List.fromList(res.data!),
        mimeType: MimeType.other,
      );

      isDownloading.value = false;

      lastSavedFilePath = saved;
      await checkIfFileExists();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            Localizations.localeOf(context).languageCode == "en"
                ? "✅ File saved successfully"
                : "✅ تم حفظ الملف بنجاح",
          ),
        ),
      );
      return true;
        } catch (e) {
      print("Download error: $e");
      isDownloading.value = false;
    }

    return false;
  }
// Open the downloaded file if it exists
  Future<void> openDownloadedFile() async {
    if (lastSavedFilePath != null) {
      await OpenFile.open(lastSavedFilePath!);
    }
  }
// Request permissions for saving files based on the platform and update the observable accordingly
  Future<bool> hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      return sdkInt >= 33
          ? _requestPermission(Permission.photos)
          : _requestPermission(Permission.storage);
    }
    if (Platform.isIOS) return _requestPermission(Permission.photos);
    return false;
  }
  // Helper method to request a specific permission and return whether it was granted
  Future<bool> _requestPermission(Permission p) async {
    if (await p.isGranted) return true;
    return (await p.request()) == PermissionStatus.granted;
  }
}
