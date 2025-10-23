import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../../Utils/memory.dart';

class SendReportController extends GetxController {
  // Form
  final formKey = GlobalKey<FormState>();
  final msgController = TextEditingController();
  final msgNode = FocusNode();

  // Dropdown data
  final categories = <Category>[].obs;
  final levels = <Category>[].obs;
  final levels2 = <Category>[].obs;
  final students = <Student>[].obs;

  // Selected values
  final selectedCategory = Rx<Category?>(null);
  final selectedLevel = Rx<Category?>(null);
  final selectedLevel2 = Rx<Category?>(null);
  final selectedStudent = Rx<Student?>(null);

  // Loading flags
  final isSending = false.obs;
  final catLoading = true.obs;
  final levelLoading = false.obs;
  final level2Loading = false.obs;
  final studentLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    catLoading.value = true;
    final data = await TeacherService().getCategories();
    categories.assignAll(data);
    catLoading.value = false;
  }

  Future<void> fetchLevels() async {
    if (selectedCategory.value == null) return;
    levelLoading.value = true;
    final data = await TeacherService().getLevels(id: selectedCategory.value!.id ?? "");
    levels.assignAll(data);
    levelLoading.value = false;
  }

  Future<void> fetchLevels2() async {
    if (selectedLevel.value == null) return;
    level2Loading.value = true;
    final data = await TeacherService().getLevels(id: selectedLevel.value!.id ?? "");
    levels2.assignAll(data);
    level2Loading.value = false;
  }

  Future<void> fetchStudents() async {
    if (selectedLevel2.value == null) return;
    studentLoading.value = true;
    final data = await TeacherService().getStudents(id: selectedLevel2.value!.id ?? "");
    students.assignAll(data);
    studentLoading.value = false;
  }

  Future<bool> sendReport(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    if (selectedStudent.value == null) return false;

    isSending.value = true;
    final success = await TeacherService().sendReport(
      id: Get.find<StorageService>().getId ,
      msg: msgController.text,
      studentId: selectedStudent.value?.id ?? "",
    );
    isSending.value = false;
    return success;
  }

  void unfocus() {
    msgNode.unfocus();
  }
}
