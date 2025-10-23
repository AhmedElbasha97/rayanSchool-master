import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/models/teachers.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import 'package:rayanSchool/services/messagesService.dart';
import 'package:rayanSchool/services/teachersService.dart';
import '../../../../../Utils/localization_services.dart';
import '../../../../../Utils/memory.dart';

class SendMessageTeacherController extends GetxController {
  // Loading flags
  var isLoadingTeacher   = false.obs;
  var isLoadingBuildings = false.obs;
  var isLoadingStages    = false.obs;
  var isLoadingClass     = false.obs;
  var isLoadingStudent   = false.obs;
  var isSendingData   = false.obs;

  // Dropdown selections
  var type = 'اختار المرسل له'.obs;        // UI label
  var selected = ''.obs;                   // backend type key

  var teachers = <Teachers>[].obs;
  var buildings = <Category>[].obs;
  var stages = <Category>[].obs;
  var classOfTeacher = <Category>[].obs;
  var students = <Student>[].obs;

  var selectedTeacher = Rxn<Teachers>();
  var selectedBuilding = Rxn<Category>();
  var selectedStage = Rxn<Category>();
  var selectedClass = Rxn<Category>();
  var selectedStudent = Rxn<Student>();

  // Fetchers --------------------------------------------------
  Future<void> getTeachers() async {
    isLoadingTeacher.value = true;
    final data = await MessagesService().getTeacher();
    teachers.assignAll([Teachers(name: "اختر مدرس"), ...data]);
    isLoadingTeacher.value = false;
  }

  Future<void> getBuildings() async {
    isLoadingBuildings.value = true;
    final data = await TeacherService().getBuildings();
    buildings.assignAll([Category(ctgName: "اختر المبنى"), ...data]);
    isLoadingBuildings.value = false;
  }

  Future<void> getStages(String parentId) async {
    isLoadingStages.value = true;
    final data = await TeacherService().getNextCategory(parentId);
    stages.assignAll([Category(ctgName: "اختر الصف"), ...data]);
    isLoadingStages.value = false;
  }

  Future<void> getClasses(String parentId) async {
    isLoadingClass.value = true;
    final data = await TeacherService().getNextCategory(parentId);
    classOfTeacher.assignAll([Category(ctgName: "اختر الفصل"), ...data]);
    isLoadingClass.value = false;
  }

  Future<void> getStudents(String classId) async {
    isLoadingStudent.value = true;
    final data = await TeacherService().getStudentIdd(classId);
    if (selected.value == "student") {
      students.assignAll([
        Student(name: "اختر الطالب"),
        Student(name: "اختر طلاب الفصل بالكامل"),
        ...data
      ]);
    }
    isLoadingStudent.value = false;
  }

  // Selection logic ------------------------------------------
  void choosingUserType(String value) {
    type.value = value;
    selectedBuilding.value = null;
    selectedStage.value = null;
    selectedClass.value = null;
    selectedStudent.value = null;
    if (value == 'مدرس') {
      selected.value = "teacher";
      getTeachers();
    } else if (value == 'طلاب') {
      selected.value = "student";
      getBuildings();
    }  else if (value == 'الادارة') {
      selected.value = "admin";
    } else {
      selected.value = "";
    }
  }

  void choosingBuilding(Category value) {
    selectedBuilding.value = value;
    selectedStage.value = null;
    selectedClass.value = null;
    selectedStudent.value = null;
    getStages(value.id ?? '');
  }

  void choosingStage(Category value) {
    selectedStage.value = value;
    selectedClass.value = null;
    selectedStudent.value = null;
    getClasses(value.id ?? '');
  }

  void choosingClass(Category value) {
    selectedClass.value = value;
    selectedStudent.value = null;
    getStudents(value.id ?? '');
  }

  void choosingStudent(Student? value) {
    selectedStudent.value = value;
    if (value?.name == "اختر طلاب الفصل بالكامل") {
      selected.value = "student_class";
    }
  }

  // Sending message ------------------------------------------
  Future<bool> sendMessage(String title, String text,BuildContext context) async {
    isSendingData.value = true;
if(selected.value == ''){
  showAlert(context,Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ?"يجب عليك اختيار من سيتلقى هذه الرسالة":"you must choose who will receive this message");
  isSendingData.value = false;
  return false;
}else if(selected.value == 'teacher' && selectedTeacher.value == Teachers(name: "اختر مدرس")){
  showAlert(context,Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ?"يجب عليك اختيار المعلم الذي سيتلقى هذه الرسالة":"you must choose the teacher who will receive this message");
  isSendingData.value = false;
  return false;

}else if((selected.value == 'student'||selected.value == 'student_parent') && selectedBuilding.value == Category(ctgName: "اختر المبنى")){
  showAlert(context,Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ?"يجب عليك اختيار المبنى":"you must choose the Building");
  isSendingData.value = false;
  return false;

}else if((selected.value == 'student'||selected.value == 'student_parent') && selectedStage.value == Category(ctgName: "اختر الصف")){
  showAlert(context,Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ?"يجب عليك اختيار الصف":"you must choose the grade");
  isSendingData.value = false;
  return false;

}else if((selected.value == 'student'||selected.value == 'student_parent') && selectedClass.value == Category(ctgName: "اختر الفصل")){
  showAlert(context,Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ?"يجب عليك اختيار الفصل":"you must choose the class");
  isSendingData.value = false;
  return false;

}else if((selected.value == 'student'||selected.value == 'student_parent') && selectedStudent.value == Student(name: "اختر الطالب")){
  showAlert(context,Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ?"يجب عليك اختيار الطالب الذي سيتلقى هذه الرسالة":"you must choose the student who will receive this message");
  isSendingData.value = false;
  return false;

}else if((selected.value == 'student'||selected.value == 'student_parent') && selectedStudent.value == Student(name: "اختر ولى الأمر")){
  showAlert(context,Get.find<StorageService>().activeLocale ==
      SupportedLocales.english
      ?"يجب عليك اختيار ولى الأمر الذي سيتلقى هذه الرسالة":"you must choose the parent who will receive this message");
  isSendingData.value = false;
  return false;

}
    final id = Get.find<StorageService>().getId;

    final toId =
    selected.value == "student_class"
        ? selectedClass.value?.id
        : selected.value == "student_parent"
        ? selectedStudent.value?.id
        : selected.value == "student"
        ? selectedStudent.value?.id
        : selected.value == "teacher"
        ? selectedTeacher.value?.id
        : "0";

    final result = await TeacherService()
        .sendMessages(id: id, text: text, title: title, type: selected.value, toId: toId ?? "0");

    isSendingData.value = false;
    return result == "true";
  }
  void showAlert(BuildContext context,String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:  Text(Get.find<StorageService>().activeLocale ==
            SupportedLocales.english
            ?"Alert":"تنبيه"),
        content:  Text(msg,),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:  Text(Get.find<StorageService>().activeLocale ==
                SupportedLocales.english
                ?"ok":"موافق"),
          ),
        ],
      ),
    );
  }
}
