import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/teachers.dart';
import 'package:rayanSchool/services/messagesService.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:rayanSchool/views/homeScreen.dart';
import 'package:rayanSchool/views/myAccountTeacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/teacher/category.dart';
import '../../../models/teacher/student.dart';

class SendMessageTeacherScreen extends StatefulWidget {
  @override
  _SendMessageTeacherScreenState createState() =>
      _SendMessageTeacherScreenState();
}

class _SendMessageTeacherScreenState extends State<SendMessageTeacherScreen> {
  bool isLoadingTeacher = true;
  bool isLoadingBuildings = true;
  bool isLoadingStages = true;
  bool isLoadingClass = true;
  bool isLoadingStudent = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _msgController = new TextEditingController();
  TextEditingController _titleController = new TextEditingController();
  FocusNode _titleNode = new FocusNode();
  FocusNode _msgNode = new FocusNode();
  String type = 'اختار المرسل له';
  String selected = "";
  List<Teachers> teachers = [];
  Teachers? selectedTeacher;
  Teachers selectTeacher = Teachers(name: "اختر مدرس");
  List<Category> buildings = [];
  Category? selectedBuildings;
  Category selectBuildings = Category(ctgName: "اختر المبنى");
  List<Category> stages = [];
  Category? selectedStages;
  Category selectStages = Category(ctgName: "اختر الصف");
  List<Category> classOfTeacher = [];
  Category? selectedClassOfTeacher;
  Category selectClassOfTeacher = Category(ctgName: "اختر الفصل");
  Student selectingAllStudentClassOfTeacher = Student(name: "اختر طلاب الفصل بالكامل");
  List<Student> student = [];
  Student? selectedStudent;
  Student? selectedParent;
  Student selectStudent = Student(name: "اختر الطالب");
  Student selectParent = Student(name: "اختر ولى الأمر");

  @override
  void initState() {
    super.initState();
  }

getBuildings() async {
    isLoadingBuildings = true;
    setState(() {
    });
    buildings = await TeacherService().getBuildings();
    buildings.add(selectBuildings);
    isLoadingBuildings = false;
    setState(() {
    });
}
  getTeachers() async {
    isLoadingTeacher = true;
    setState(() {});
    teachers = await MessagesService().getTeacher();
    teachers.add(selectTeacher);
    isLoadingTeacher = false;
    setState(() {});
  }

  getStages() async {
    isLoadingStages = true;
    setState(() {
    });
    stages = await TeacherService().getNextCategory(selectedBuildings?.id??'');
    stages.add(selectStages);

    isLoadingStages = false;
    setState(() {
    });
  }
  getClass() async {
    isLoadingClass = true;
    setState(() {
    });
    classOfTeacher = await TeacherService().getNextCategory(selectedStages?.id??'');

    classOfTeacher.add(selectClassOfTeacher);

    isLoadingClass = false;
    setState(() {
    });
  }
  getStudents() async {
    isLoadingStudent = true;
    setState(() {
    });
    student = await TeacherService().getStudentIdd(selectedClassOfTeacher?.id??"");
    if(selected == "student"){
      student.add(selectStudent);
      if(selected == "student"){
        student.add(selectingAllStudentClassOfTeacher);
      }
    }else{
      student.add(selectParent);
    }
    isLoadingStudent = false;
    setState(() {
    });
  }
  choosingUserType(String? value) {
    type = value!;
    selected = type == 'مدرس' ? "teacher" :selected = type == 'طلاب' ? "student" :selected = type == 'ولى أمر' ? "student_parent" : "admin";
    if(type == 'مدرس'){
      selectedTeacher = null;
      getTeachers();
    }
    if(type == 'طلاب'||type == 'ولى أمر'){
      getBuildings();
      selectedBuildings = null;
      selectedStages = null;
      selectedClassOfTeacher = null;
      selectedStudent = null;
    }
    setState(() {});
  }
  choosingBuilding(Category? value){
    selectBuildings = value!;
    selectedBuildings = value;
    selectedStages = null;
    selectedClassOfTeacher = null;
    selectedStudent = null;
    getStages();
    setState(() {});
  }
  choosingStage(Category? value){
    selectStages = value!;
    selectedStages = value;
    selectedClassOfTeacher = null;
    selectedStudent = null;
    getClass();
    setState(() {});
  }
  choosingClass(Category? value){
      selectClassOfTeacher = value!;
      selectedClassOfTeacher = value;
      selectedStudent = null;
      getStudents();

    setState(() {});
  }
  choosingStudent(Student? value){
    if(value?.name == "اختر طلاب الفصل بالكامل"){
      selectStudent = value!;
      selectedStudent = value;
      selected = "student_class";
    }else{
      selectStudent = value!;
      selectParent = value;
      selectedStudent = value;
    }
    setState(() {

    });
  }
  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      isLoadingTeacher = true;
      setState(() {});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("id");
      String done = await TeacherService().sendMessages(id:id??"",text: _msgController.text,title: _titleController.text,type:selected,toId:  selected=="student_class"?"${selectedClassOfTeacher?.id}" :selected=="student_parent"?"${selectedStudent?.id}":selected=="student"?"${selectedStudent?.id}":selected=="teacher"?"${selectedTeacher?.id??''}":"0");
      isLoadingTeacher = false;
      setState(() {});
      if (done == "true") {
        final snackBar = SnackBar(content: Text("تم أرسال الرساله"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
        pushPageReplacement(context, MyAccountTeacher());

      } else {

      }
      popPage(context);
    }
  }

  void unFocus() {
    _titleNode.unfocus();
    _msgNode.unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        body:  Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        AppLocalizations.of(context)?.translate('sendMessage')??"",
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: _titleController,
                        focusNode: _titleNode,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.message),
                          counterText: "",
                          hintText:
                              AppLocalizations.of(context)?.translate('title'),
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
                                ?.translate('titleError');
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        focusNode: _msgNode,
                        controller: _msgController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.message_rounded),
                          counterText: "",
                          hintText:
                              AppLocalizations.of(context)?.translate('message'),
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
                                ?.translate('MessageError');
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: DropdownButton<String>(
                        icon: Container(),
                        value: type,
                        items: <String>[
                          'اختار المرسل له',
                          'مدرس',
                          'الادارة',
                          'ولى أمر',
                          'طلاب'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          choosingUserType(value);
                        },
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: selected == "student"||selected == "student_parent"||selected == "student_class"
                          ?isLoadingBuildings
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 40,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: mainColor,width: 1)
                            ),

                            child: Center(
                            child: CircularProgressIndicator(),
                            ),
                          )
                          :  DropdownButton<Category>(
                        icon: Container(),
                        value: selectBuildings,
                        items: buildings.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text("${value.ctgName}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          choosingBuilding(value);
                        },
                      ):Container()
                          ,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child:selectedBuildings == null ?SizedBox():selected == "student"||selected == "student_parent"||selected == "student_class"
                          ?isLoadingStages
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 40,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: mainColor,width: 1)
                            ),

                            child: Center(
                            child: CircularProgressIndicator(),
                            ),
                          )
                          :  DropdownButton<Category>(
                        icon: Container(),
                        value: selectStages,
                        items: stages.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text("${value.ctgName}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          choosingStage(value);
                        },
                      ):Container()
                          ,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child:selectedStages == null ?SizedBox():selected == "student"||selected == "student_parent"||selected == "student_class"
                          ?isLoadingClass
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 40,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: mainColor,width: 1)
                            ),

                            child: Center(
                            child: CircularProgressIndicator(),
                            ),
                          )
                          :  DropdownButton<Category>(
                        icon: Container(),
                        value: selectClassOfTeacher,
                        items: classOfTeacher.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text("${value.ctgName}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          choosingClass(value);
                        },
                      ):Container()
                          ,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child:selected == "student"||selected == "student_class"?selectedClassOfTeacher == null?SizedBox():selected == "student"||selected == "student_class"
                          ?isLoadingStudent
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 40,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: mainColor,width: 1)
                            ),

                            child: Center(
                            child: CircularProgressIndicator(),
                            ),
                          )
                          :  DropdownButton<Student>(
                        icon: Container(),
                        value: selectStudent,
                        items: student.map((Student value) {
                          return DropdownMenuItem<Student>(
                            value: value,
                            child: Text("${value.name}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          choosingStudent(value);
                        },
                      ):Container():SizedBox()
                          ,
                    ),
                    Container(
                      height: 50,
                      child:selected == "student_parent"?selectedClassOfTeacher == null?SizedBox():selected == "student_parent"
                          ?isLoadingStudent
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 40,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: mainColor,width: 1)
                            ),

                            child: Center(
                            child: CircularProgressIndicator(),
                            ),
                          )
                          :  DropdownButton<Student>(
                        icon: Container(),
                        value: selectParent,
                        isExpanded: true,
                        items: student.map((Student value) {
                          return DropdownMenuItem<Student>(


                            value: value,
                            child: value.name ==  "اختر ولى الأمر"?Text("${value.name}"):Text("ولى أمر الطالب:${value.name}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          choosingStudent(value);
                        },
                      ):Container():SizedBox()
                          ,
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: selected == "teacher"
                          ?isLoadingTeacher
                          ? Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 40,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: mainColor,width: 1)
                            ),

                            child: Center(
                            child: CircularProgressIndicator(),
                            ),
                          )
                          :  DropdownButton<Teachers>(
                        icon: Container(),
                        value: selectTeacher,
                        items: teachers.map((Teachers value) {
                          return DropdownMenuItem<Teachers>(
                            value: value,
                            child: Text("${value.name}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectTeacher = value!;
                          selectedTeacher = value;
                          setState(() {});
                        },
                      ):Container()
                          ,
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
