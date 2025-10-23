import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/services/teachersService.dart';

import '../../../../../Utils/localization_services.dart';
import '../../../../../Utils/memory.dart';
import '../../../../../Utils/validator.dart';
import '../../../../../globals/helpers.dart';

class AddHomeworkController extends GetxController {
  final titleController = TextEditingController();
  final msgController   = TextEditingController();
  bool formValidated = false;
  final _validatorHelber = ValidatorHelper.instance;
  // dropdown data
  var categories = <Category>[].obs;
  var levels     = <Category>[].obs;
  var levels2    = <Category>[].obs;
  final formKey = GlobalKey<FormState>();

  var selectedCategory = Rx<Category?>(null);
  var selectedLevel    = Rx<Category?>(null);
  var selectedLevel2   = Rx<Category?>(null);
  final titleNode = FocusNode();
  final msgNode = FocusNode();
  RxBool nameState = false.obs;
  RxBool nameValidated = false.obs;
  // loading states
  var catLoading   = true.obs;
  var levelLoading = false.obs;
  var level2Loading= false.obs;
  var sending      = false.obs;

  // picked file
  var selectedFile      = Rx<File?>(null);
  var selectedFileName  = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }
  void onNameUpdate(String? value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value == "") {
        nameState.value = false;
      }
    });
    print("hi from update");

  }

  String? validateName(String? name) {
    print("hi from validate");
    var validateName = _validatorHelber.validateName(name);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (validateName == null && name != "") {
        nameValidated.value = true;
        nameState.value = true;
      } else {
        nameValidated.value = true;
      }
    });

    print("hi from validate");

    return validateName;
  }

  Future<void> fetchCategories() async {
    catLoading.value = true;
    final list = await TeacherService().getCategories();
    categories.assignAll(list);
    catLoading.value = false;
  }

  Future<void> fetchLevels() async {
    if (selectedCategory.value == null) return;
    levelLoading.value = true;
    final list = await TeacherService().getLevels(id: selectedCategory.value!.id ?? "");
    levels.assignAll(list);
    levelLoading.value = false;
  }

  Future<void> fetchLevels2() async {
    if (selectedLevel.value == null) return;
    level2Loading.value = true;
    final list = await TeacherService().getLevels(id: selectedLevel.value!.id ?? "");
    levels2.assignAll(list);
    level2Loading.value = false;
  }

  /// Pick any file or image
  Future<void> pickFileAny() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
      selectedFileName.value = result.files.single.name;
    }
  }

  Future<void> pickFromGallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      selectedFile.value = File(img.path);
      selectedFileName.value = img.name;
    }
  }

  Future<void> pickFromCamera() async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img != null) {
      selectedFile.value = File(img.path);
      selectedFileName.value = img.name;
    }
  }

  String formatFileSize() {
    final file = selectedFile.value;
    if (file == null) return '';
    final bytes = file.lengthSync();
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(2)} KB';
    final mb = kb / 1024;
    if (mb < 1024) return '${mb.toStringAsFixed(2)} MB';
    final gb = mb / 1024;
    return '${gb.toStringAsFixed(2)} GB';
  }
  Future<String> sendPressed(context) async {
    formValidated = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (formValidated) {
     return await submit(context);
    }
    return 'failed';
  }

  /// Call TeacherService to send homework
  Future<String> submit(context) async {
    if (selectedLevel2.value == null) return 'no-class';
    sending.value = true;
    var res;
    res = await TeacherService().addHomeWork(
      classId: selectedLevel2.value?.id ?? "",
      details: msgController.text,
      title:   titleController.text,
      selectedFile: selectedFile.value,
    );

    final locale = Get.find<StorageService>().activeLocale ==
        SupportedLocales.english;
    final msg = res == "true"
        ? (locale
        ?  "Homework added" : "تمت الإضافة")
        : (locale
        ? "Failed, try again" : "فشل الإضافة");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
        res == "true" ? Colors.green : Colors.red,
        content: Row(
          children: [
            Icon(res == "true" ? Icons.check : Icons.close,
                color: Colors.white),
            const SizedBox(width: 10),
            Text(msg,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
    if (res == "true") popPage(context);
    sending.value = false;
    return res;
  }
}
