import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/homeWorkCard.dart';
import 'package:rayanSchool/views/loggedUser/homework/homework_details/homework_details_screen.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Widgets/loader.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/homeworks_controller.dart';

class HomeWorkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeWorkController(), permanent: false);

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
// Display an empty state if there are no homework items available
        final list = controller.homeworks;
        if (list.isEmpty) {
          return Container(
            height: Get.height * 0.75,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/noBooks.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "no homework available"
                      : "لا يوجد واجب مدرسى متوفره لان",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
// Display the homework list using ListView.builder
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            final hw = list[index];
            return InkWell(
              onTap: () {
                Get.to(()=>HomeWorkDetailsScreen(id: hw.id ?? ""),transition: Transition.rightToLeft,preventDuplicates: true);

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomeWorkCard(
                  title: hw.title ?? "",
                  date: hw.date ?? "",
                  teacherName: hw.teacherName ?? "",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
