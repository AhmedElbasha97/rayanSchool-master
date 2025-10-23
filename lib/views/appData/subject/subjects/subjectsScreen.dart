import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import 'package:rayanSchool/views/appData/subject/subject_detail/subjectDetails.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/subject_controller.dart';

class SubjectsScreen extends StatelessWidget {
  SubjectsScreen({Key? key}) : super(key: key);

  final SubjectsController controller = Get.put(SubjectsController(), permanent: false);

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

        if (controller.subjects.isEmpty) {
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
                      ? "No weekly messages available"
                      : "لا يوجد رسائل أسبوعية متوفرة الآن",
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
          itemCount: controller.subjects.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final subject = controller.subjects[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(()=>SubjectDetailsScreen(id: subject.id),transition: Transition.rightToLeft,preventDuplicates: false);


                },
                child: ListTile(
                  title: Text(subject.miName ?? ""),
                  trailing: const Icon(Icons.arrow_forward_ios),
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
