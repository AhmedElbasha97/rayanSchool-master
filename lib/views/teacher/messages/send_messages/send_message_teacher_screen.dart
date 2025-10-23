import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import '../../../../Utils/translation_key.dart';
import '../../../../models/teacher/category.dart';
import '../../../../models/teacher/student.dart';
import '../../../../models/teachers.dart';
import 'controller/send_messsage_teacher_controller.dart';

class SendMessageTeacherScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _msgController = TextEditingController();

  SendMessageTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SendMessageTeacherController(), permanent: false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(

          iconTheme: new IconThemeData(color: mainColor),
          backgroundColor: Color(0xFFdcdbdb),
          title: Image.asset(
            "assets/images/logo.png",
            scale: 4.5,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            children: [
              Center(
                child: Text(
                  sendMessage.tr,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 30),

              // Title field
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration(context, title.tr,),
                validator: (v) => v!.isEmpty
                    ? titleError.tr
                    : null,
              ),
              const SizedBox(height: 15),

              // Message field
              TextFormField(
                controller: _msgController,

                decoration: _inputDecoration(context, message.tr,),
                validator: (v) => v!.isEmpty
                    ? messageError.tr
                    : null,
              ),
              const SizedBox(height: 15),

              // Type dropdown
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 1), // 👈 yellow border
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  value: c.type.value,
                  isExpanded: true,
                  icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
                  underline: const SizedBox(), // remove the default underline

                  borderRadius: BorderRadius.circular(15),
                  items: const [
                    'اختار المرسل له',
                    'مدرس',
                    'الادارة',
                    'طلاب'
                  ].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                  onChanged: (v) => c.choosingUserType(v ?? ''),
                ),
              )),
              const SizedBox(height: 10,),
              // --- Buildings / Stages / Class / Student dropdowns ---
              Obx(() => c.selected.value.contains("student")
                  ? _buildCategoryDropdown(context, c.isLoadingBuildings.value,
                  c.buildings, c.selectedBuilding.value, c.choosingBuilding)
                  : const SizedBox()),
              const SizedBox(height: 10,),
              Obx(() => c.selectedBuilding.value != null &&
                  c.selected.value.contains("student")
                  ? _buildCategoryDropdown(context, c.isLoadingStages.value,
                  c.stages, c.selectedStage.value, c.choosingStage)
                  : const SizedBox()),
              const SizedBox(height: 10,),
              Obx(() => c.selectedStage.value != null &&
                  c.selected.value.contains("student")
                  ? _buildCategoryDropdown(context, c.isLoadingClass.value,
                  c.classOfTeacher, c.selectedClass.value, c.choosingClass)
                  : const SizedBox()),
              const SizedBox(height: 10,),
              Obx(() => (c.selected.value == "student" ||
                  c.selected.value == "student_class") &&
                  c.selectedClass.value != null
                  ? _buildStudentDropdown(context, c)
                  : const SizedBox()),
              const SizedBox(height: 10,),
              Obx(() => c.selected.value == "student_parent" &&
                  c.selectedClass.value != null
                  ? _buildStudentDropdown(context, c)
                  : const SizedBox()),
              const SizedBox(height: 10,),
              // Teacher dropdown
              Obx(() => c.selected.value == "teacher"
                  ? _buildTeacherDropdown(context, c)
                  : const SizedBox()),

              const SizedBox(height: 30),

              Obx(() => Center(
                  child:c.isSendingData.value?
                  Container(
                      decoration: BoxDecoration( color: mainColor, shape: BoxShape.circle ),
                      child: Padding( padding: const EdgeInsets.all(8.0),
                        child: Center( child: CircularProgressIndicator( ), ),)
                  ) :ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor, minimumSize: const Size(200, 40)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final ok = await c.sendMessage(
                            _titleController.text, _msgController.text,context);
                        final msg = ok
                            ?
                            'تم إرسال  الرساله بنجاح'
                            :
                            'حدث خطاء أثناء إرسال  الرساله';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(msg),
                            backgroundColor: ok ? Colors.green : Colors.red,
                          ),
                        );
                        if (ok) Get.back();
                      }
                    },
                    child: Text(
                        send.tr?? "Send",
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helpers ---------------------------------------------------
  InputDecoration _inputDecoration(BuildContext ctx, String key) {
    return InputDecoration(
      prefixIcon:  Icon(Icons.message,color: mainColor),
      hintText:key,
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
    );

  }

  Widget _buildCategoryDropdown(BuildContext ctx, bool loading,
      List<Category> items, Category? selected, Function(Category) onChange) {
    if (loading) {
      return Container(
          width: 220,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),child: const Center(child: CircularProgressIndicator()));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 1), // 👈 yellow border
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<Category>(
        value: selected ?? items.first,
        isExpanded: true,
        underline: const SizedBox(), // remove the default underline

        icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
        borderRadius: BorderRadius.circular(15),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e.ctgName ?? '')))
            .toList(),
        onChanged: (v) => onChange(v!),
      ),
    );
  }

  Widget _buildStudentDropdown(BuildContext ctx, SendMessageTeacherController c) {
    if (c.isLoadingStudent.value) {
      return Container(
          width: 220,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),child: const Center(child: CircularProgressIndicator()));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 1), // 👈 yellow border
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<Student>(
        value: c.selectedStudent.value ?? c.students.first,
        isExpanded: true,
        underline: const SizedBox(), // remove the default underline

        borderRadius: BorderRadius.circular(15),
        icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
        items: c.students
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e.name ?? ''),
        ))
            .toList(),
        onChanged: (v) => c.choosingStudent(v),
      ),
    );
  }

  Widget _buildTeacherDropdown(BuildContext ctx, SendMessageTeacherController c) {
    if (c.isLoadingTeacher.value) {
      return Container(
          width: 220,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),child: const Center(child: CircularProgressIndicator()));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 1), // 👈 yellow border
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<Teachers>(
        value: c.selectedTeacher.value ?? c.teachers.first,
        icon:  Icon(Icons.arrow_drop_down_circle_outlined,color: mainColor),
        underline: const SizedBox(), // remove the default underline

        isExpanded: true,
        items: c.teachers
            .map((e) => DropdownMenuItem(value: e, child: Text(e.name ?? '')))
            .toList(),
        onChanged: (v) => c.selectedTeacher.value = v,
      ),
    );
  }
}
