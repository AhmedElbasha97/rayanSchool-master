import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rayanSchool/models/Student/schadules_student_model.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:rayanSchool/Utils/memory.dart';

class SchadulesController extends GetxController {
  var isLoading = true.obs;
  Rx<SchadulesStudentModel>? data = SchadulesStudentModel().obs;

  /// Fetch schedule data for the logged-in student
  Future<void> fetchSchadules() async {
    try {
      isLoading.value = true;
      data?.value = await LoggedUser().getSchadules(
        Get.find<StorageService>().getId,
      )??SchadulesStudentModel(img: "");
    } catch (e) {
      print("Error fetching schedules: $e");
      data?.value = SchadulesStudentModel(img: "");
    } finally {
      isLoading.value = false;
    }
  }

  /// Download the schedule image to the Downloads folder
  Future<void> downloadImage() async {
    final imgUrl = data?.value.img ?? "";
    if (imgUrl.isEmpty) {
      Get.snackbar("Error", "No schedule image found");
      return;
    }

    String savename = "schedules.png";
    String path = "";

    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      Directory dir = Directory('/storage/emulated/0/Download');
      if (dir.existsSync()) {
        String savePath = "${dir.path}/$savename";
        path = savePath;

        try {
          await Dio().download(
            imgUrl,
            savePath,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                print("${(received / total * 100).toStringAsFixed(0)}%");
              }
            },
          );
          Get.snackbar("Success", "Image saved to $path",
              snackPosition: SnackPosition.BOTTOM);
        } on DioError catch (e) {
          Get.snackbar("Error", "Failed to download image: ${e.message}",
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } else {
      Get.snackbar("Permission Denied", "No permission to read/write storage");
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchSchadules();
  }
}
