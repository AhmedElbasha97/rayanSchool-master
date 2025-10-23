import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SchadulesDetailedController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Force landscape mode when entering the screen
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }

  @override
  void onClose() {
    // Restore portrait mode when leaving the screen
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.onClose();
  }
}
