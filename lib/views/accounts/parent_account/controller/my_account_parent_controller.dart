import 'package:get/get.dart';
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
//fetch children data and set the selected child based on stored user ID
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
//change the selected child and update the stored user ID accordingly this bec the parent id is for only getting children but every thing else work with the children id
  Future<void> selectChild(ChildModel child) async {
    chosenChild.value = child.name ?? "";

    await Get.find<StorageService>().getId;
  }
}