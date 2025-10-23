import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/views/Student/schadules/schadules_details/schadules_detailed_screen.dart';
import '../../../../I10n/app_localizations.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import '../../../../../Widgets/loader.dart';
import 'controller/schadules_controller.dart';

class SchadulesScreen extends StatelessWidget {
  SchadulesScreen({Key? key}) : super(key: key);

  final SchadulesController controller = Get.put(SchadulesController(), permanent: false);

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

        if ((controller.data?.value.img?.isEmpty ?? true)&&controller.data?.value.img! != "") {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
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
                      ? "No schedule available"
                      : "لا يوجد جداول متوفرة الآن",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              child: Hero(
                tag: 'imageHero',
                child: CachedNetworkImage(
                  imageUrl: controller.data?.value.img ?? "",
                  imageBuilder: (context, image) {
                    return Container(
                      width: Get.width,
                      height: Get.height * 0.3,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                      ),
                    );
                  },
                  placeholder: (context, image) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Loader(
                          width: MediaQuery.of(context).size.width,
                          height: 150.0,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/no_data_slideShow.png"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    );
                  },
                ),
              ),
              onTap: () {
                Get.to(()=>SchadulesDetailedImageScreen(
                  link: controller.data?.value.img ?? "",
                ),transition: Transition.rightToLeft,preventDuplicates:true);

              },
            ),
            const SizedBox(height: 15),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: InkWell(
                  onTap: () => controller.downloadImage(),
                  child: Container(
                    width: Get.width * 0.7,
                    height: 40,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "حمل الجدول",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
