import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../../Utils/localization_services.dart';
import '../../../../../Utils/memory.dart';
import '../../../../../globals/helpers.dart';

class SentRecommendationController extends GetxController {
  // form
  final formKey = GlobalKey<FormState>();
  final msgController = TextEditingController();
  final msgNode = FocusNode();

  // dropdown data
  final categories = <Category>[].obs;
  final levels = <Category>[].obs;
  final levels2 = <Category>[].obs;
  final students = <Student>[].obs;
  final recommendationList = <Map<String?, String?>>[].obs;

  // selected values
  final selectedCategory = Rx<Category?>(null);
  final selectedLevel = Rx<Category?>(null);
  final selectedLevel2 = Rx<Category?>(null);
  final selectedStudent = Rx<Student?>(null);
  final recommendationTypeValue = "".obs;
  final recommendationTypeTitle = "".obs;

  // flags
  final isSending = false.obs;
  final catLoading = true.obs;
  final levelLoading = false.obs;
  final level2Loading = false.obs;
  final studentLoading = false.obs;
  final serverLoading = false.obs;
  final categoryLoading = true.obs;

  final studentsLoading = false.obs;
  final recommendationLoading = true.obs;
  final isServerLoading = false.obs;
  final textFieldActivated = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchRecommendationData("1");
  }

  Future<void> fetchCategories() async {
    catLoading.value = true;
    final data = await TeacherService().getCategories();
    categories.assignAll(data..add(Category(ctgName: "اختار القسم")));
    catLoading.value = false;
  }

  Future<void> fetchLevels() async {
    if (selectedCategory.value == null) return;
    levelLoading.value = true;
    final data = await TeacherService().getLevels(id: selectedCategory.value!.id ?? "");
    levels.assignAll(data..add(Category(ctgName: "اختار المرحلة")));
    levelLoading.value = false;
  }

  Future<void> fetchLevels2() async {
    if (selectedLevel.value == null) return;
    level2Loading.value = true;
    final data = await TeacherService().getLevels(id: selectedLevel.value!.id ?? "");
    levels2.assignAll(data..add(Category(ctgName: "اختار الفصل")));
    level2Loading.value = false;
  }

  Future<void> fetchStudents() async {
    if (selectedLevel2.value == null) return;
    studentLoading.value = true;
    final data = await TeacherService().getStudents(id: selectedLevel2.value!.id ?? "");
    students.assignAll(data..add(Student(name: "اختار طالب")));
    studentLoading.value = false;
  }


  onChangeOfTextField(){
    textFieldActivated.value = true;
  }
  Future<void> fetchRecommendationData(String type) async {
    recommendationLoading.value = true;
    final data = await TeacherService().getRecommendations(type);
    recommendationList.assignAll(data);
    recommendationLoading.value = false;
  }

  Future<bool> sendRecommendation(context) async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    if (selectedStudent.value == null) return false;
    if (recommendationTypeValue.value.isEmpty) return false;

    serverLoading.value = true;
    final msg = await TeacherService().sentRecommendation(
      recommendationType: "1",
      recommendationValue: recommendationTypeValue.value,
      notes: msgController.text,
      studentId: selectedStudent.value?.id ?? "",
    );
    final lang = Get.find<StorageService>().activeLocale ==
        SupportedLocales.english
    ;
    final text = msg == "done"
        ? (lang
        ? "Recommendation has been sent successfully"
        : "تم أرسال توصية بنجاح")
        : (lang
        ? "Try sending a recommendation again"
        : "حاول أرسال توصية مره اخرى");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: msg == "done" ? Colors.green : Colors.red,
        content: Row(
          children: [
            Icon(msg == "done" ? Icons.check : Icons.close, color: Colors.white),
            const SizedBox(width: 10),
            Text(text,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
    if (msg == "done") popPage(context);
    serverLoading.value = false;
    return msg == "done";
  }

  void unfocus() {
    msgNode.unfocus();
  }
}
