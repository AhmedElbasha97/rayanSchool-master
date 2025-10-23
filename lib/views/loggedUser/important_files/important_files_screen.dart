import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/homeWorkCard.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Widgets/loader.dart';
import '../../../globals/commonStyles.dart';
import 'controller/important_files_controller.dart';

class FilesImportantScreen extends StatelessWidget {
  const FilesImportantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilesImportantController(), permanent: false);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset("assets/images/logo.png", scale: 4.5),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }
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
