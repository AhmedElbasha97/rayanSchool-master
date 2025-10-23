import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../../Utils/localization_services.dart';
import '../../../../../Utils/memory.dart';
import '../../../../../globals/helpers.dart';

class SendRecommendationsController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final  msgController = TextEditingController();
  final  msgNode = FocusNode();

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
  final recommendationList = <Map<String?, String?>>[].obs;

  final categoryLoading = true.obs;

  final studentsLoading = false.obs;
  final recommendationLoading = true.obs;
  final isServerLoading = false.obs;
  final textFieldActivated = false.obs;
  // Selected values
  var selectCategory = Category(ctgName: "اختار القسم").obs;
  var selectLevel = Category(ctgName: "اختار المرحلة").obs;
  var selectLevel2 = Category(ctgName: "اختار الفصل").obs;
  var selectStudent = Student(name: "اختار طالب").obs;

  var recommendationValue = "2"; // behavioural
  var recommendationTypeValue = "".obs;
  var recommendationTypeTitle = "".obs;

  @override
  void onInit() {
    super.onInit();
    getRecommendationData("2");
    fetchCategories();
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


  Future<void> getRecommendationData(String type) async {
    final data = await TeacherService().getRecommendations(type);
    recommendationList.assignAll(data);
    recommendationLoading.value = false;
  }

  Future<String?> sendMessage(BuildContext context) async {
    print("message sent");
    isServerLoading.value = true;
    if ((formKey.currentState!.validate())) {
      final msg = await TeacherService().sentRecommendation(
        recommendationType: recommendationValue,
        recommendationValue: recommendationTypeValue.value,
        notes: msgController.text,
        studentId: selectStudent.value.id ?? "",
      );
      isServerLoading.value = false;
      if (msg == "done") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english

                  ? "Recommendation has been sent successfully"
                  : "تم أرسال توصية بنجاح",
              style: TextStyle(color: Colors.white),
            )));
        popPage(context);
      } else if (msg != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english

                  ? "Try sending a recommendation again"
                  : "حاول أرسال توصية مره اخرى",
              style: TextStyle(color: Colors.white),
            )));
      }
      return msg;
    }
    return null;
  }
}
