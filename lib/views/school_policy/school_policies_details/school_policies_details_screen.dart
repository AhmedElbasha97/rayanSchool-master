import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../globals/commonStyles.dart';
import 'controller/school_policies_details_controller.dart';

class SchoolPoliciesDetailsScreen extends StatelessWidget {
  final String? id;

  SchoolPoliciesDetailsScreen({Key? key, this.id}) : super(key: key);

  final SchoolPoliciesDetailsController controller =
  Get.put(SchoolPoliciesDetailsController(), permanent: false);

  /// Extract plain text from HTML
  String extractTextFromHtml(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? "";
  }

  /// Open external URL
  Future<void> _onOpenLink(Uri url, BuildContext context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      showAlert(context);
    }
  }

  /// Show alert dialog if link cannot be opened
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("تنبيه"),
          content: const Text("لا يمكن فتح الرابط"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("موافق"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Fetch data when screen is built
    controller.fetchDetails(id ?? "");

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
        if (controller.details.isEmpty) {
          return Center(
            child: Text(
              Get.find<StorageService>().activeLocale ==
                  SupportedLocales.english
                  ?"No details available"
                  : "لا توجد تفاصيل متاحة",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.details.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final detail = controller.details[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section
                    Container(
                      width: Get.width,
                      height: Get.height * 0.3,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(detail.image ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Title
                    Text(
                      "${detail.title}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),

                    // Description with clickable links
                    Linkify(
                      onOpen: (link) async {
                        Uri uri = Uri.parse(link.url);
                        await _onOpenLink(uri, context);
                      },
                      text: extractTextFromHtml("${detail.description}"),
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      linkStyle: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 10),

                    // Download button if file exists
                    detail.file == ""
                        ? const SizedBox()
                        : Center(
                      child: InkWell(
                        onTap: () async {
                          Uri uri = Uri.parse(detail.file ?? "");
                          await _onOpenLink(uri, context);
                        },
                        child: Container(
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                "${Localizations.localeOf(context).languageCode == "en" ? "download file" : "تحميل الملف"}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style:
                                const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
