import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class SchoolWordController extends GetxController {
  final bool isAbout;

  SchoolWordController({this.isAbout = false});

  var isLoading = true.obs;
  var word = Rxn<AboutSchool>();

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      word.value = isAbout
          ? await AppInfoService().getAboutSchool()
          : await AppInfoService().getSchoolWord();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
}