import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import '../../../../../Widgets/mainButton.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import '../../../../models/teacher/category.dart';
import '../../../../models/teacher/student.dart';
import 'controller/sent_recommendation _controller.dart';

class SendRecommendationsScreens extends StatelessWidget {
  final c = Get.put(SendRecommendationsController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => c.msgNode.unfocus(),
      child: Scaffold(

        appBar: AppBar(
          iconTheme: IconThemeData(color: mainColor),
          backgroundColor: const Color(0xFFdcdbdb),
          title: Text(
            Get.find<StorageService>().activeLocale ==
                SupportedLocales.english

                ?"Send a recommendation"
                : "أرسال توصية",
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: c.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: [
                _title(context,
                    en: "Choose the reason recommendation:",
                    ar: "أختر سبب التوصيه :"),
                const SizedBox(height: 15),
                Obx(() => _buildRecommendationDropdown(context)),
                const SizedBox(height: 15),
                _title(context, en: "Choose the student:", ar: "أختر الطالب :"),
                const SizedBox(height: 15),
                Obx(() {

                  if (c.catLoading.value) return _loadingBox();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor, width:1), // 👈 yellow border
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),

                // Level Dropdown
                Obx(() {
                  if (c.selectedCategory.value == null) return const SizedBox();
                  if (c.levelLoading.value) return _loadingBox();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor, width: 1), // 👈 yellow border
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),

                // Level2 Dropdown
                Obx(() {
                  if (c.selectedLevel.value == null) return const SizedBox();
                  if (c.level2Loading.value) return _loadingBox();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor, width: 1), // 👈 yellow border
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),

                // Student Dropdown
                Obx(() {
                  if (c.selectedLevel2.value == null) return const SizedBox();
                  if (c.studentLoading.value) return _loadingBox();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor, width:1), // 👈 yellow border
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),
            Obx(() =>                c.selectedStudent.value == null?  const SizedBox():
            _messageField(context)),
                const SizedBox(height: 15),
                Obx(() =>       c.selectedStudent.value == null?  const SizedBox():c.isServerLoading.value
                    ? Container(
                    decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                    child: Padding( padding: const EdgeInsets.all(8.0),
                      child: Center( child: CircularProgressIndicator( ), ),)
                )
                    : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AppBtn(
                    onClick: () async {
                      await c.sendMessage(context);

                    },
                    label:
                    Get.find<StorageService>().activeLocale ==
                        SupportedLocales.english

                        ? "Send recommendation"
                        : "أرسال توصيه",
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
  Widget _title(BuildContext context, {required String en, required String ar}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        Get.find<StorageService>().activeLocale ==
            SupportedLocales.english

            ? en : ar,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRecommendationDropdown(BuildContext context) {
    if (c.recommendationLoading.value) return Container(
        width: 220,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),child: const Center(child: CircularProgressIndicator()));
    if (c.recommendationList.isEmpty) return SizedBox();

    return _decoratedDropdown<Map<String?, String?>>(
      hint: c.recommendationTypeTitle.value.isEmpty
          ? (Get.find<StorageService>().activeLocale ==
          SupportedLocales.english

          ? "Choose the type of Behavioural recommendation"
          : "أختر نوع التوصيه السلوكيه ")
          : c.recommendationTypeTitle.value,
      items: c.recommendationList
          .map((map) => DropdownMenuItem(
        value: map,
        child: Text(map.values.first ?? ""),
      ))
          .toList(),
      value: null,
      onChanged: (val) {
        c.recommendationTypeTitle.value = val?.values.first ?? "";
        c.recommendationTypeValue.value = val?.keys.first ?? "";
      },
    );
  }



  Widget _messageField(BuildContext context) => Column(
    children: [
      c.selectLevel2.value==""?SizedBox():Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          maxLines: 4,
          focusNode: c.msgNode,
          controller: c.msgController,
          onChanged: (v) => c.onChangeOfTextField(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.message_rounded,color: mainColor),
            hintText: typeMsg.tr,
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: mainColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10)),
         ),
          validator: (v) => v == null || v.isEmpty
              ? reportError.tr
              : null,
        ),
      ),
     c.textFieldActivated.value ? _keyboardToolbar(context) : SizedBox()
    ],
  );

  Widget _keyboardToolbar(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              c.msgController.text += '\n';
              c.msgController.selection = TextSelection.collapsed(
                  offset: c.msgController.text.length);
            },
            child: Text(Get.find<StorageService>().activeLocale ==
                SupportedLocales.english


                ? "Next Line"
                : "السطر التالي")),
        ElevatedButton(
            onPressed: () => c.msgNode.unfocus(),
            child: Text(Get.find<StorageService>().activeLocale ==
                SupportedLocales.english

                ? "Done"
                : "تم")),
      ],
    ),
  );

  Widget _decoratedDropdown<T>({
    T? value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InputDecorator(

        decoration: InputDecoration(
          // Yellow border when not focused
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:  BorderSide(color:mainColor, width: 1),
          ),
          // Yellow border when focused
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:  BorderSide(color: mainColor, width: 1),
          ),
          // Optional: yellow border when there's an error
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:  BorderSide(color: mainColor, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:  BorderSide(color: mainColor, width: 1),
          ),
        ),

        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            borderRadius: BorderRadius.circular(15),
            icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
            hint: hint != null ? Text(hint) : null,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
