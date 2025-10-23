import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/student.dart';

import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import 'controller/send_report_controller.dart';

class SendReport extends StatelessWidget {
  SendReport({Key? key}) : super(key: key);

  final c = Get.put(SendReportController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: c.unfocus,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: mainColor),
          backgroundColor: const Color(0xFFdcdbdb),
          title: Image.asset(
            "assets/images/logo.png",
            scale: 4.5,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: c.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            children: [
              // No Rx here, so no Obx
              TextFormField(
                focusNode: c.msgNode,
                controller: c.msgController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon:  Icon(Icons.message_rounded,color: mainColor),
                  hintText: writeReport.tr,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (v) =>
                v == null || v.isEmpty ? reportError.tr : null,
              ),
              const SizedBox(height: 15),

              // Category Dropdown
              const SizedBox(height: 10,),
        Obx(() {

                if (c.catLoading.value) return _loadingBox();
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor, width: 2), // 👈 yellow border
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: DropdownButton<Category>(
                    value: c.selectedCategory.value,
                    hint: const Text("اختار القسم"),
                    isExpanded: true,
                    underline: const SizedBox(), // remove the default underline

                    borderRadius: BorderRadius.circular(15),
                    icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                    items: c.categories
                        .map((cat) => DropdownMenuItem(
                        value: cat, child: Text(cat.ctgName ?? "")))
                        .toList(),
                    onChanged: (val) {
                      c.selectedCategory.value = val;
                      c.levels.clear();
                      c.selectedLevel.value = null;
                      c.fetchLevels();
                    },
                  ),
                );
              }),
              const SizedBox(height: 15),

              // Level Dropdown
              Obx(() {
                if (c.selectedCategory.value == null) return const SizedBox();
                if (c.levelLoading.value) return _loadingBox();
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor, width: 2), // 👈 yellow border
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<Category>(
                    value: c.selectedLevel.value,
                    hint: const Text("اختار المرحلة"),
                    isExpanded: true,
                    underline: const SizedBox(), // remove the default underline

                    borderRadius: BorderRadius.circular(15),
                    icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                    items: c.levels
                        .map((lvl) => DropdownMenuItem(
                        value: lvl, child: Text(lvl.ctgName ?? "")))
                        .toList(),
                    onChanged: (val) {
                      c.selectedLevel.value = val;
                      c.levels2.clear();
                      c.selectedLevel2.value = null;
                      c.fetchLevels2();
                    },
                  ),
                );
              }),
              const SizedBox(height: 15),

              // Level2 Dropdown
              Obx(() {
                if (c.selectedLevel.value == null) return const SizedBox();
                if (c.level2Loading.value) return _loadingBox();
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor, width: 2), // 👈 yellow border
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<Category>(
                    value: c.selectedLevel2.value,
                    hint: const Text("اختار الفصل"),
                    isExpanded: true,
                    underline: const SizedBox(), // remove the default underline

                    borderRadius: BorderRadius.circular(15),
                    icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                    items: c.levels2
                        .map((lvl2) => DropdownMenuItem(
                        value: lvl2, child: Text(lvl2.ctgName ?? "")))
                        .toList(),
                    onChanged: (val) {
                      c.selectedLevel2.value = val;
                      c.students.clear();
                      c.selectedStudent.value = null;
                      c.fetchStudents();
                    },
                  ),
                );
              }),
              const SizedBox(height: 15),

              // Student Dropdown
              Obx(() {
                if (c.selectedLevel2.value == null) return const SizedBox();
                if (c.studentLoading.value) return _loadingBox();
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor, width: 2), // 👈 yellow border
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton<Student>(
                    value: c.selectedStudent.value,
                    hint: const Text("اختار طالب"),
                    isExpanded: true,
                    underline: const SizedBox(), // remove the default underline

                    borderRadius: BorderRadius.circular(15),
                    icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                    items: c.students
                        .map((st) => DropdownMenuItem(
                        value: st, child: Text(st.name ?? "")))
                        .toList(),
                    onChanged: (val) => c.selectedStudent.value = val,
                  ),
                );
              }),
              const SizedBox(height: 30),

              // Send Button
              Obx(() {
                if (c.selectedStudent.value == null) return const SizedBox();
                if (c.isSending.value) {
                  return Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return Center(
                  child: InkWell(
                    onTap: () async {
                      final success = await c.sendReport(context);
                      final locale = Get.find<StorageService>().activeLocale ==
                          SupportedLocales.english;
                      final msg = success
                          ? (locale
                          ? 'the report has been sent successfully'
                          : "تم إرسال التقرير بنجاح")
                          : (locale
                          ? 'Try sending a report again'
                          : "حدث خطاء أثناء إرسال التقرير");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                          success ? Colors.green : Colors.red,
                          content: Row(
                            children: [
                              Icon(success ? Icons.check : Icons.close,
                                  color: Colors.white),
                              const SizedBox(width: 10),
                              Text(msg,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                      if (success) popPage(context);
                    },
                    child: Container(
                      width: Get.width * 0.7,
                      height: 40,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        send.tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Small helper widget for showing a bordered loading box
  Widget _loadingBox() {
    return Container(
      width: 220,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
