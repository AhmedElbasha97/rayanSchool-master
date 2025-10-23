// controllers/homework_details_controller.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rayanSchool/models/teacher/HomeWorkDetails.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../../Utils/memory.dart';

class HomeworkDetailsController extends GetxController {
  final isLoading = true.obs;
  final homework = <HomeWorkDetailsTeacherModel>[].obs;
  RxBool downloadingFile = false.obs;
  final String? hwId;
  HomeworkDetailsController({this.hwId});

  @override
  void onInit() {
    super.onInit();
    fetchDetails();
  }

  /// Fetch homework details depending on user type
  Future<void> fetchDetails() async {

    final userId = Get.find<StorageService>().getId ?? "";
    final isTeacher = Get.find<StorageService>().getUserType == "TEACHER";


    final list = await TeacherService().getHomeworkDetails(
      id: isTeacher ? userId : hwId??"",
      homeworkId: isTeacher ? hwId : userId,
    );
    homework.assignAll(list ?? []);
    isLoading.value = false;
  }

  /// --- File download helpers ---
  Future<bool> hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      return await _request(Permission.storage) &&
          await _request(Permission.accessMediaLocation) &&
          await _request(Permission.manageExternalStorage);
    } else if (Platform.isIOS) {
      return await _request(Permission.photos);
    }
    return false;
  }

  Future<bool> _request(Permission p) async {
    if (await p.isGranted) return true;
    final res = await p.request();
    return res.isGranted;
  }

  String fileName(String path) => path.split('/').last;

  Future<String?> saveFile() async {
    if (!await hasAcceptedPermissions()) return null;
    if (homework.isEmpty || homework.first.homeworkFile == null) return null;
    downloadingFile.value = true;
    final baseDir = await getExternalStorageDirectory();
    final newPath = baseDir!.path.split("Android")[0] + "AlRayan_App";
    final targetDir = Directory(newPath);
    await targetDir.create(recursive: true);

    final url = homework.first.homeworkFile!;
    final name = fileName(url);
    final savePath = "${targetDir.path}/$name";

    await Dio().download(url, savePath);
    downloadingFile.value = false;
    return "$newPath/$name";
  }
}
