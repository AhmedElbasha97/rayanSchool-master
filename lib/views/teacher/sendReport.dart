import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/teacher/category.dart';
import 'package:rayanSchool/models/teacher/student.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendReport extends StatefulWidget {
  @override
  _SendReportState createState() => _SendReportState();
}

class _SendReportState extends State<SendReport> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _msgController = new TextEditingController();
  FocusNode _msgNode = new FocusNode();

  List<Category> categories = [];
  List<Category> levels = [];
  List<Category> levels2 = [];
  List<Student> student = [];

  bool isLoading = false;
  bool categoryloading = true;
  bool levelLoading = false;
  bool level2Loading = false;
  bool studentsLoading = false;

  Category selectCatogory = Category(ctgName: "اختار القسم");
  Category selectLevel = Category(ctgName: "اختار المرحلة");
  Category selectLevel2 = Category(ctgName: "اختار الفصل");
  Student selectStudent = Student(name: "اختار طالب");

  Category? selectedCatogory;
  Category? selectedLevel;
  Category? selectedLevel2;
  Student? selectedStudent;

  getCatgories() async {
    categories = await TeacherService().getCategories();
    categories.add(selectCatogory);
    categoryloading = false;
    setState(() {});
  }

  getLevels() async {
    levels = await TeacherService().getLevels(id: selectedCatogory?.id??"");
    levels.add(selectLevel);
    levelLoading = false;
    setState(() {});
  }
  getLevels2() async {
    levels2 = await TeacherService().getLevels(id: selectedLevel?.id??"");
    levels2.add(selectLevel2);
    level2Loading = false;
    setState(() {});
  }

  getStudent() async {
    student = await TeacherService().getStudents(id: selectedLevel2?.id??"");
    student.add(selectStudent);
    studentsLoading = false;
    setState(() {});
  }

  void unFocus() {
    _msgNode.unfocus();
    setState(() {});
  }

  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      if (selectedStudent != null) {
        isLoading = true;
        setState(() {});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? id = prefs.getString("id");
        bool done = await TeacherService().sendReport(
            id: id??"", msg: _msgController.text, studentId: selectedStudent?.id??"");
        if (done ) {
          final snackBar = SnackBar(content:
          Row(children: [
            const Icon(Icons.check, color: Colors.white,),
            const SizedBox(width: 10,),
            Text(Localizations.localeOf(context).languageCode == "en" ?'the report has been sent successfully':"تم إرسال التقرير بنجاح", style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            ),
          ],),
              backgroundColor: Colors.green
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          popPage(context);


        } else {
          final snackBar = SnackBar(content:
          Row(children: [
            const Icon(Icons.close, color: Colors.white,),
            const SizedBox(width: 10,),
            Text( Localizations.localeOf(context).languageCode == "en" ?'Try sending a report again':'حدث خطاء أثناء إرسال  التقرير', style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            ),
          ],),
              backgroundColor: Colors.red
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        popPage(context);
      }

    }
  }

  @override
  void initState() {
    super.initState();
    getCatgories();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        focusNode: _msgNode,
                        controller: _msgController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.message_rounded),
                          counterText: "",
                          hintText: AppLocalizations.of(context)
                              ?.translate('writeReport'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF184e7a), width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF184e7a), width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value!.length < 1) {
                            return AppLocalizations.of(context)
                                ?.translate('reportError');
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: DropdownButton<Category>(
                        icon: Container(),
                        value: selectCatogory,
                        items: categories.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text("${value.ctgName}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectCatogory = value!;
                          selectedCatogory = value;
                          levelLoading = true;
                          getLevels();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: levelLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : levels.isEmpty
                              ? Container()
                              : DropdownButton<Category>(
                                  icon: Container(),
                                  value: selectLevel,
                                  items: levels.map((Category value) {
                                    return DropdownMenuItem<Category>(
                                      value: value,
                                      child: Text("${value.ctgName}"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectLevel = value!;
                                    selectedLevel = value;
                                    level2Loading = true;
                                    getLevels2();
                                    setState(() {});
                                  },
                                ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      width: 300,
                      height: 50,
                      child: level2Loading
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : levels.isEmpty
                          ? Container()
                          : DropdownButton<Category>(
                        icon: Container(),
                        value: selectLevel2,
                        items: levels2.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text("${value.ctgName}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectLevel2 = value!;
                          selectedLevel2 = value;
                          studentsLoading = true;
                          getStudent();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: studentsLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : student.isEmpty
                              ? Container()
                              : DropdownButton<Student>(
                                  icon: Container(),
                                  value: selectedStudent,
                                  items: student.map((Student value) {
                                    return DropdownMenuItem<Student>(
                                      value: value,
                                      child: Text("${value.name}"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectStudent = value!;
                                    selectedStudent = value;
                                    setState(() {});
                                  },
                                ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: InkWell(
                          onTap: () {
                            sendMessage();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 40,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)?.translate('send')??"",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
