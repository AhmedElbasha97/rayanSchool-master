import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../globals/commonStyles.dart';
import '../../../../Widgets/loader.dart';
import 'controller/recommendation_academic_list_controller.dart';

class RecommendationAcademicListScreen extends StatelessWidget {
  RecommendationAcademicListScreen({Key? key}) : super(key: key);

  final RecommendationAcademicController controller =
  Get.put(RecommendationAcademicController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
        title: Text(
          Get.find<StorageService>().activeLocale ==
              SupportedLocales.english
              ? "Recommendation academic list"
              : "قائمة التوصيات الأكاديمية",
          style: TextStyle(color: mainColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: mainColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader(
            height: Get.height,
          );
        }

        if (controller.recommendationList.isEmpty) {
          return SizedBox(
            height:  Get.height,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  Image.asset("assets/images/no_recomendation_data.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "No Recommendation academic available"
                      : "لا يوجد توصيات أكاديمية متوفرة الآن",
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
          physics: const BouncingScrollPhysics(),
          itemCount: controller.recommendationList.length,
          itemBuilder: (context, index) {
            final recommendation = controller.recommendationList[index];
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
                        recommendation.title ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recommendation.student ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recommendation.subject ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recommendation.teacher ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recommendation.notes ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        maxLines: null,
                      ),
                      const SizedBox(height: 8),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          controller.formatDate(recommendation),
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
