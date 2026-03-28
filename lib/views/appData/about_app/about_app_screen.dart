import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../Widgets/loader.dart';
import '../../../globals/commonStyles.dart';
import 'controller/about_app_controller.dart';

class AboutAppScreen extends StatelessWidget {
  final AboutAppController controller = Get.put(AboutAppController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar with logo and custom colors
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
        if (controller.loading.value) {
          return Loader();
        }

        final word = controller.word.value;

        if (word == null) {
          // Display an error message if data is null
          return Center(
            child: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english
                  ?"An error occurred while loading data.":"حدث خطأ أثناء تحميل البيانات",
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        // Display the about app data using ListView
        return ListView(
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.3,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("${word.image}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: word.description),
            )
          ],
        );
      }),
    );
  }
}

