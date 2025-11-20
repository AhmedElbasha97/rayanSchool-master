// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/file_icons_widget.dart';
import 'package:rayanSchool/Widgets/mainButton.dart';
import '../../../../Utils/localization_services.dart';
import '../../../../Utils/memory.dart';
import '../../../../Utils/translation_key.dart';
import '../../../../Widgets/text_field_widget.dart';
import '../../../../globals/commonStyles.dart';

import 'controller/add_home_work_controller.dart';

class AddHomeWorkScreen extends StatelessWidget {
  const AddHomeWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AddHomeworkController(), permanent: false);
    final locale = Get.find<StorageService>().activeLocale ==
        SupportedLocales.english
        ;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
        title: Text(locale?  "Add Homework" : "أضافه واجب منزلى"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: c.formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 30),
            children: [
              Obx(
                    ()=> _buildDropdown(
                  context,
                  label: locale? "Choose section" : "اختر القسم",
                  items: c.categories,
                  value: c.selectedCategory.value,
                  loading: c.catLoading.value,
                  onChanged: (cat) {
                    c.selectedCategory.value = cat;
                    c.fetchLevels();
                  },
                ),
              ),
              Obx(
                    ()=> c.selectedCategory.value == null?Container():_buildDropdown(
                  context,
                  label: locale  ? "Choose stage" : "اختر المرحلة",
                  items: c.levels,
                  value: c.selectedLevel.value,
                  loading: c.levelLoading.value,
                  onChanged: (lvl) {
                    c.selectedLevel.value = lvl;
                    c.fetchLevels2();
                  },
                ),
              ),
              Obx(
                    ()=> c.selectedLevel.value == null?Container(): _buildDropdown(
                  context,
                  label: locale ? "Choose class" : "اختر الفصل",
                  items: c.levels2,
                  value: c.selectedLevel2.value,
                  loading: c.level2Loading.value,
                  onChanged: (lvl2) => c.selectedLevel2.value = lvl2,
                ),
              ),
              const SizedBox(height: 15),
              Obx(
                    ()=>c.selectedLevel2.value == null?Container(): Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: Get.height*0.1,
                    width: Get.width,
                    child: CustomInputField(
                      isPhoneNumber: false,
                      textAligning: Get.find<StorageService>().activeLocale == SupportedLocales.english?TextAlign.left:TextAlign.right,
                      labelText:  locale ? "Homework Title" : "عنوان واجب منزلى",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      iconOfTextField: Icon(Icons.home_work_outlined,
                          color: mainColor),
                      focusNode: c.titleNode,
                      controller: c.titleController,
                      onchange: c.onNameUpdate,
                      validator: c.validateName,
                      icon: (c.nameValidated.value)
                          ? (c.nameState.value)
                          ? const Icon(Icons.check_rounded,
                          color: kSuccessColor)
                          : const Icon(
                        Icons.close_outlined,
                        color: kErrorColor,
                      )
                          : null,
                      hasGreenBorder: false, hasborder: true,
                    ),
                  ),
                ),),
              ),
              const SizedBox(height: 15),
              Obx(
                    ()=> c.selectedLevel2.value == null?Container():Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                      child: TextFormField(
                                        validator: (value) {
                      if (value!.length < 2) {
                        messageError.tr;
                      }
                      return null;
                                        },
                                        focusNode: c.msgNode,
                                        controller: c.msgController,
                                        maxLines: 4,
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                      hintText:
                      typeMsg.tr,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 2.0),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                                        ),
                                      ),
                    ),
              ),
              const SizedBox(height: 20),
              Obx(
                    ()=> c.selectedLevel2.value == null?Container():InkWell(
                  onTap: () => _showPickOptions(context, c, locale),
                  child: _pickedFileCard(context, c, locale),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                    ()=> c.selectedLevel2.value == null?Container():c.sending.value
                    ? Container(
                    decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                    child: Padding( padding: const EdgeInsets.all(8.0),
                      child: Center( child: CircularProgressIndicator( ), ),)
                )
                    : AppBtn(
                  label: locale ? "Add Homework" : "أضافه واجب منزلى",
                  onClick: () async {
                    final res = await c.sendPressed(context);



                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext ctx,
      {required String label,
        required List items,
        required dynamic value,
        required bool loading,
        required Function(dynamic) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: loading
          ? Container(
          width: 220,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),child: const Center(child: CircularProgressIndicator()))
          : DropdownButtonFormField(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(15),
                  icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
        decoration: InputDecoration(
          labelText: label,
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
                  value: value,
                  items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e.ctgName ?? "")))
            .toList(),
                  onChanged: onChanged,
                ),
    );
  }



  Widget _pickedFileCard(BuildContext ctx, AddHomeworkController c, bool locale) {
    final hasFile = c.selectedFileName.isNotEmpty;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: mainColor),
      ),
      child: hasFile
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.selectedFileName.value,
                    style: TextStyle(
                        color: mainColor, fontWeight: FontWeight.bold)),
                Text(c.formatFileSize(),
                    style: TextStyle(color: mainColor)),
              ],
            ),
          ),
          FileIconWidget(fileName: c.selectedFileName.value),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locale
                ? "Choose file to upload"
                : "أختر الملف الذى تريد إرفاقه",
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Icon(Icons.file_copy_outlined, color: mainColor, size: 40)
        ],
      ),
    );
  }

  void _showPickOptions(BuildContext ctx, AddHomeworkController c, bool locale) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: Text(locale ? "Pick File" : "اختيار الملف"),
              onTap: () { Get.back(); c.pickFileAny(); },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(locale ? "Pick from Gallery" : "اختر من المعرض"),
              onTap: () { Get.back(); c.pickFromGallery(); },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(locale? "Take Photo" : "التقط صورة"),
              onTap: () { Get.back(); c.pickFromCamera(); },
            ),
          ],
        ),
      ),
    );
  }
}
