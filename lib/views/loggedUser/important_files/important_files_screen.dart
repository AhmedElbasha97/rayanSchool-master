import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/homeWorkCard.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Widgets/loader.dart';
import '../../../globals/commonStyles.dart';
import 'controller/important_files_controller.dart';
// This screen displays a list of important files for logged-in users. It uses the GetX package for state management and localization services to support multiple languages. The screen includes an AppBar with a logo and custom colors, and it handles loading states and empty data scenarios gracefully.
//but the school asked to remove this screen from the app so i just hide it and keep the code for future use if they want to add it again
class FilesImportantScreen extends StatelessWidget {
  const FilesImportantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilesImportantController(), permanent: false);

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
        // Display an empty state if there are no important files available
        if (controller.files.isEmpty) {
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
                      ?"No data available":"لا توجد بيانات متاحة",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
// Display the important files list using ListView.builder
        return ListView.builder(
          itemCount: controller.files.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final file = controller.files[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  final url = file.file ?? "";
                  controller.sendClick(url,context);
                },
                child: HomeWorkCard(
                  title: file.title ?? "",
                  date: file.desc ?? "",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
