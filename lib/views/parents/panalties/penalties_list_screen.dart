import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../globals/commonStyles.dart';
import '../../../../Widgets/loader.dart';
import 'controller/penalties_list_controller.dart';

class PenaltiesListScreen extends StatelessWidget {
  PenaltiesListScreen({Key? key}) : super(key: key);

  final PenaltiesController controller = Get.put(PenaltiesController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with logo and custom colors
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
        title: Text(
          Get.find<StorageService>().activeLocale ==
              SupportedLocales.english
              ? "Conduct and penalties"
              : "السلوك والجزاءات",
          style: TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: mainColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Obx(() {
        // Display a loading indicator while data is being fetched
        if (controller.isLoading.value) {
          return Loader(
            height: Get.height * 0.75,
          );
        }
// Display an error message if data is empty
        if (controller.penaltiesList.isEmpty) {
          return Container(
            height: Get.height * 0.75,
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
                      ? "No penalties available"
                      : "لا يوجد جزاءات متوفرة الآن",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
// Display the penalties list using ListView.builder
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.penaltiesList.length,
          itemBuilder: (context, index) {
            final penalty = controller.penaltiesList[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade500, width: 1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        penalty.student ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        penalty.penaltiesListModelClass ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        penalty.level ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        penalty.action ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        penalty.notes ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          controller.formatDate(penalty),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
