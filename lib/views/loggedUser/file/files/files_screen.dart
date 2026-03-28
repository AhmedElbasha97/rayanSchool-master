import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/homeWorkCard.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/Utils/localization_services.dart';
import 'package:rayanSchool/Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../file_details/file_details_screen.dart';
import 'controller/files_controller.dart';

class FilesScreen extends StatelessWidget {
  final FilesController controller = Get.put(FilesController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with logo and custom colors
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset("assets/images/logo.png", scale: 4.5),
        centerTitle: true,
      ),
      body: Obx(() {
        // Display a loading indicator while data is being fetched
        if (controller.isLoading.value) {
          return Loader();
        }

        // Display an error message if data is empty
        if (controller.files?.isEmpty??true) {
          return Container(
            height: Get.height * 0.75,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/noData.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "no file available"
                      : "لا يوجد ملفات متوفرة الآن",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
        // Display the file list using ListView.builder

        return ListView.builder(
          itemCount: controller.files?.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final file = controller.files?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(()=>FileDetailsScreen(id: file?.id ?? ""),transition: Transition.rightToLeft,preventDuplicates: true);

                },
                child: HomeWorkCard(
                  title: file?.title ?? "",
                  date: file?.date ?? "",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
