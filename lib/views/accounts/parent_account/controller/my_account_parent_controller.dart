import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/memory.dart';
import '../../../../models/parents/child_model.dart';
import '../../../../services/ParentsService.dart';


class MyAccountParentController extends GetxController {
  var isLoading = true.obs;
  var childData = <ChildModel>[].obs;
  var chosenChild = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchChildData();
  }

  Future<void> fetchChildData() async {
    try {
      isLoading.value = true;
      childData.value = await ParentService().getChildList();
      await _setSelectedChild();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _setSelectedChild() async {

    final userId = Get.find<StorageService>().getId;

    for (var child in childData) {
      if (child.id == userId) {
        chosenChild.value = child.name ?? "";
        break;
      }
    }
  }

  Future<void> selectChild(ChildModel child) async {
    chosenChild.value = child.name ?? "";

    await Get.find<StorageService>().getId;
  }
}