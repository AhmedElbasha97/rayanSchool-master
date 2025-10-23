import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import '../../../../Widgets/loader.dart';
import '../../../../Widgets/mainButton.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/news_details_controller.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String? id;

  NewsDetailsScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsDetailsController(id ?? ""), permanent: false);

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
      body: Obx(
            () => controller.isLoading.value
            ? Loader()
            : controller.newsDetails.isEmpty
            ? Center(
          child: Text(
            Get.find<StorageService>().activeLocale ==
                SupportedLocales.english
                ? "No news details available"
                : "لا توجد تفاصيل للأخبار",
            style: const TextStyle(fontSize: 16),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.newsDetails.length,
          itemBuilder: (BuildContext context, int index) {
            final news = controller.newsDetails[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      news.title ?? "",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 15),

                    // Images carousel
                    if (news.images != null &&
                        news.images!.isNotEmpty)
                      news.images?[0]==""?Center(
                        child: Text(
                          Get.find<StorageService>().activeLocale ==
                              SupportedLocales.english
                              ? "No news images available"
                              : "لا توجد صور للأخبار",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ):CarouselSlider(
                        options: CarouselOptions(
                          height: 150.0,
                          autoPlay: true,
                        ),
                        items: news.images!.map((img) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:img,
                                imageBuilder: ((context, image){
                                  return Container(
                                    width: Get.width,
                                    height: Get.height * 0.3,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                                placeholder: (context, image){
                                  return   Container(
                                    width: Get.width,
                                    height: Get.height * 0.3,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration:BoxDecoration(
                                      color:  const Color(0xFFF2F0F3),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(
                                            0.0,
                                            0.0,
                                          ),
                                          blurRadius: 13.0,
                                          spreadRadius: 2.0,
                                        ), //BoxShadow
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.2),
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 0.0,
                                          spreadRadius: 0.0,
                                        ), //BoxShadow
                                      ],
                                    ),

                                  ).animate(onPlay: (controller) => controller.repeat())
                                      .shimmer(duration: 1200.ms, color:  mainColor.withAlpha(10))
                                      .animate() // this wraps the previous Animate in another Animate
                                      ;
                                },
                                errorWidget: (context, url, error){
                                  return Container(
                                    width: Get.width,
                                    height: Get.height * 0.3,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Image.asset("assets/images/27002.jpg",fit: BoxFit.fitWidth,),
                                  );
                                },
                              );
                            },
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 15),

                    // Description
                    Html(data: news.description ?? ""),
                    const SizedBox(height: 15),

                    // Video Button
                    news.video != null && news.video!.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppBtn(
                        label: viewVideo.tr,
                        onClick: () async {
                          final url = Uri.parse(news.video!);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Could not launch video"),
                              ),
                            );
                          }
                        },
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
