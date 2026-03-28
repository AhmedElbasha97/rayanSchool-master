import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class SchoolWordController extends GetxController {
  final bool isAbout;

  SchoolWordController({this.isAbout = false});

  var isLoading = true.obs;
  var word = Rxn<AboutSchool>();
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
  //fetch data based on the isAbout flag and update the loading state accordingly bec this screen is used for both about school and school word
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


}