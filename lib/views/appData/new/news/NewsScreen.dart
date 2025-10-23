import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/globals/helpers.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../news_details/NewsDetailsScreen.dart';
import 'controller/news_controller.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);

  final NewsController controller = Get.put(NewsController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Loader();
        }

        if (controller.newsList.isEmpty) {
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
                      ?  "No news available"
                      : "لا يوجد أخبار متوفرة الآن",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: controller.newsList.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final newsItem = controller.newsList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  pushPage(
                    context,
                    NewsDetailsScreen(id: newsItem.id ?? ""),
                  );
                },
                child: ListTile(
                  title: Text(newsItem.title ?? ""),
                  subtitle: Text(newsItem.brief ?? ""),
                  trailing: Icon(Icons.arrow_forward_ios,color: mainColor,),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      }),
    );
  }
}
