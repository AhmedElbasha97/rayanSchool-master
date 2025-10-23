import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/localization_services.dart';
import '../../../Utils/memory.dart';
import '../../../globals/commonStyles.dart';
import '../school_policies_details/school_policies_details_screen.dart';
import 'controller/school_policies_controller.dart';

class SchoolPoliciesScreen extends StatelessWidget {
  const SchoolPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SchoolPoliciesController controller = Get.put(SchoolPoliciesController(), permanent: false);

    // Fetch data when screen is built
    controller.fetchPolicies();

    return Scaffold(
      appBar: AppBar(

        iconTheme: new IconThemeData(color: mainColor),
        backgroundColor: Color(0xFFdcdbdb),
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.subjects?.isEmpty??true) {
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
                      ? "No School Policies available"
                      : "لا يوجد سياسات مدرسية متوفرة الآن",
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
          itemCount: controller.subjects?.length??0,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            final policy = controller.subjects?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.to(()=>
                    SchoolPoliciesDetailsScreen(
                      id: policy?.id,
                    ),
                    transition: Transition.rightToLeft,
                  );
                },
                child: ListTile(
                  title: Text("${policy?.title}"),
                  trailing:  Icon(Icons.arrow_forward_ios,color: mainColor,),
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
