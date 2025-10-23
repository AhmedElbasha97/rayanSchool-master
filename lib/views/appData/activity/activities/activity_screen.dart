import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Widgets/loader.dart';
import '../../../../globals/commonStyles.dart';
import '../activity_detailed/activity_detailed_screen.dart';
import 'cotnroller/activity_controller.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActivityController controller = Get.put(ActivityController(), permanent: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          Get.find<StorageService>().activeLocale ==
              SupportedLocales.english
              ? "School Activities List"
              : "قائمة الأنشطة المدرسية",
          style:  TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Loader();
          }

          if (controller.activityList.isEmpty) {
            return Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/images/no_recomendation_data.png"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    Get.find<StorageService>().activeLocale ==
                        SupportedLocales.english
                        ? "No school activities available"
                        : "لا يوجد أنشطه المدرسيه متوفره لان",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.activityList.length,
            itemBuilder: (context, index) {
              final activity = controller.activityList[index];
              return InkWell(
                onTap: () {
                  Get.to(ActivityDetailedScreen(activityId: activity.id ?? ""),transition: Transition.rightToLeft,preventDuplicates: true);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        activity.miName ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
