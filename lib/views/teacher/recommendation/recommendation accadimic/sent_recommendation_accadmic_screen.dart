import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import '../../../../../Widgets/mainButton.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import '../../../../globals/commonStyles.dart';
import 'controller/sent_recommendation_accadmic_controller.dart';

class SentRecommendationAccadmicScreen extends StatelessWidget {
  const SentRecommendationAccadmicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SentRecommendationController(), permanent: false);
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
    Widget _messageField(BuildContext context) => Column(
      children: [
        c.selectedLevel2.value==""?SizedBox():Padding(
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
    Widget buildDropdown<T>({
      required RxList<T> list,
      required Rx<T?> selected,
      required String hint,
      required void Function(T?) onChanged,
      bool loading = false,
    }) {
      return Obx(() {
        if (loading) return Container(
            width: 220,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: mainColor, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),child: const Center(child: CircularProgressIndicator()));
        if (list.isEmpty) return Container();
        return InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(width: 1, color: Colors.yellow),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              hint: Text(selected.value == null ? hint : selected.value.toString()),
              value: selected.value,
              items: list
                  .map((v) => DropdownMenuItem<T>(
                value: v,
                child: Text(v is Category
                    ? v.ctgName ?? ""
                    : v is Student
                    ? v.name ?? ""
                    : v.toString()),
              ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        );
      });
    }

    return GestureDetector(
      onTap: c.unfocus,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: mainColor),
          backgroundColor: const Color(0xFFdcdbdb),
          title: Text(Get.find<StorageService>().activeLocale ==
              SupportedLocales.english

              ? "Send a recommendation"
              : "أرسال توصية"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: c.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
              children: [
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english

                      ? "Choose the reason recommendation:"
                      : "أختر سبب التوصيه :",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Obx(() {

                  if (c.recommendationLoading.value) {
                    return Container(
                  width: 220,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 1),
                  borderRadius: BorderRadius.circular(15),
                  ),child: const Center(child: CircularProgressIndicator()));

                  }
                  return  InputDecorator(
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
                      child: DropdownButton<Map<String?, String?>>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(15),
                        icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                        hint: Text(
                          c.recommendationTypeTitle.value.isEmpty
                              ?(Get.find<StorageService>().activeLocale ==
                              SupportedLocales.english
                              ?"Choose the type of academic recommendation"
                              : "أختر نوع التوصيه أكاديمية")
                              : c.recommendationTypeTitle.value,
                        ),
                        items: c.recommendationList.map((map) {
                          return DropdownMenuItem(
                            value: map,
                            child: Text(map.values.first ?? ""),
                          );
                        }).toList(),
                        onChanged: (val) {
                          c.recommendationTypeTitle.value = val?.values.first ?? "";
                          c.recommendationTypeValue.value = val?.keys.first ?? "";
                        },
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 15),
                Text(
                  Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english

                      ? "Choose the student:"
                      : "أختر الطالب :",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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
                const SizedBox(height: 15),
                Obx(() =>                c.selectedStudent.value == null?  const SizedBox():
                _messageField(context)),
                const SizedBox(height: 15),
                Obx(() => (c.selectedStudent.value==null)?SizedBox():c.serverLoading.value
                    ?  Container(
                    decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                    child: Padding( padding: const EdgeInsets.all(8.0),
                      child: Center( child: CircularProgressIndicator( ), ),)
                )
                    : AppBtn(
                  onClick: () async {
                    final ok = await c.sendRecommendation(context);

                  },
                  label: Get.find<StorageService>().activeLocale ==
                      SupportedLocales.english
                      ? "sent recommendation"
                      : "أرسال توصيه",
                )),
              ],
            ),
          ),
        ),
      ),
    );

  }


}
