import 'package:flutter/material.dart';

import '../../I10n/app_localizations.dart';
import '../../globals/commonStyles.dart';
import '../../globals/helpers.dart';
import '../../globals/widgets/mainButton.dart';
import '../../models/teacher/category.dart';
import '../../models/teacher/student.dart';
import '../../services/teachersService.dart';
import '../myAccountTeacher.dart';

class SentRecommendationAccadmicScreen extends StatefulWidget {
  const SentRecommendationAccadmicScreen({Key? key}) : super(key: key);

  @override
  _SentRecommendationAccadmicScreenState createState() =>
      _SentRecommendationAccadmicScreenState();
}

class _SentRecommendationAccadmicScreenState
    extends State<SentRecommendationAccadmicScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _msgController = new TextEditingController();
  FocusNode _msgNode = new FocusNode();

  List<Category> categories = [];
  List<Category> levels = [];
  List<Category> levels2 = [];
  List<Student> student = [];

  bool isLoading = false;
  bool recommendationIsLoading = true;
  bool categoryloading = true;
  bool levelLoading = false;

  bool level2Loading = false;
  bool studentsLoading = false;

  Category selectCatogory = Category(ctgName: "اختار القسم");
  Category selectLevel = Category(ctgName: "اختار المرحلة");
  Category selectLevel2 = Category(ctgName: "اختار الفصل");
  Student selectStudent = Student(name: "اختار طالب");
  List<Map<String?,String?>> recommendationList =[];
  Category? selectedCatogory;
  Category? selectedLevel;

  Category? selectedLevel2;
  Student? selectedStudent;
  bool isServerLoading = false;
  String recommendationTitle = "";
  String recommendationValue = "1";
  String recommendationTypeValue = "";
  String recommendationTypeTitle = "";

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
        if(!isServerLoading){
          setState(() {
            isServerLoading = true;
          });

          String msg =   await TeacherService().sentRecommendation(
              recommendationType: recommendationValue, recommendationValue: recommendationTypeValue,notes: _msgController.text, studentId: selectedStudent?.id??"");
          if (msg == "done") {
            setState(() {
              isServerLoading = false;
            });
            final snackBar = SnackBar(content:
            Row(children: [
              Icon(Icons.check,color: Colors.white,),
              SizedBox(width: 10,),
              Text(Localizations.localeOf(context).languageCode == "en" ?'Recommendation has been sent successfully':'تم أرسال توصية بنجاح',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              ),
            ],),
                backgroundColor:Colors.green
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            popPage(context);
          } else {
            setState(() {
              isServerLoading = false;
            });
            final snackBar = SnackBar(content:
            Row(children: [
              Icon(Icons.close,color: Colors.white,),
              SizedBox(width: 10,),
              Text(Localizations.localeOf(context).languageCode == "en" ?'Try sending a recommendation again':'حاول أرسال توصية مره اخرى',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              ),
            ],),
                backgroundColor:Colors.red
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);


          }
        }


      }else{
        setState(() {
          isServerLoading = false;
        });
      }
    }else{
      setState(() {
        isServerLoading = false;
      });
    }
  }


  getRecommendationData(String type) async {
    recommendationList = await TeacherService().getRecommendations(type);
    recommendationIsLoading = false;
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    getCatgories();
    getRecommendationData( "1");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(Localizations.localeOf(context).languageCode == "en"
              ?"Send a recommendation":"أرسال توصية"),
          centerTitle: true,
        ),
        body:
        Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric( vertical: 30),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(Localizations.localeOf(context).languageCode == "en"
                    ?"Choose the reason recommendation:":"أختر سبب التوصيه :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Container(
                width: 300,
                height: 70,
                child: recommendationIsLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : recommendationList.isEmpty
                    ? Container()
                    :  Container(
                  width: 300,
                  height: 80,

                  child:InputDecorator(
                    decoration:  InputDecoration(border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.yellow),
                    )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String?,String?>>(
                        isExpanded: true,

                        hint: Text(recommendationTypeTitle==""?Localizations.localeOf(context).languageCode == "en"
                            ?"Choose the type of academic recommendation":"أختر نوع التوصيه أكاديمية ":recommendationTypeTitle),
                        items:recommendationList.map((map) {
                          return DropdownMenuItem(
                            child: Text(map.values.first??""),
                            value:map,
                          );
                        }).toList(),
                        onChanged: (value) {
                          recommendationTypeTitle =value?.values.first??"";
                          recommendationTypeValue =value?.keys.first??"";
                          setState(() {

                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(Localizations.localeOf(context).languageCode == "en"
                    ?"Choose the student:":"أختر الطالب :",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child:InputDecorator(
                    decoration:  InputDecoration(border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.yellow),
                    )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Category>(
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
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child: levelLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : levels.isEmpty
                      ? Container()
                      : InputDecorator(
                    decoration:  InputDecoration(border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.yellow),
                    )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Category>(
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
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child: level2Loading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : levels2.isEmpty
                      ? Container()
                      : InputDecorator(
                    decoration:  InputDecoration(border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.yellow),
                    )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Category>(
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
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child: studentsLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : student.isEmpty
                      ? Container()
                      : InputDecorator(
                    decoration:  InputDecoration(border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 1.0, style: BorderStyle.solid,color: Colors.yellow),
                    )),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Student>(
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
                  ),
                ),
              ),
              Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        maxLines: 4,
                        focusNode: _msgNode,
                        controller: _msgController,
                        keyboardType: TextInputType.multiline,

                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.message_rounded),
                          counterText: "",

                          hintText: AppLocalizations.of(context)?.translate('typeMsg')??"",
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
                  ),
                  if (_msgNode.hasFocus) _buildCustomKeyboardToolbar(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              !isServerLoading? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppBtn(
                  onClick: () async {
                    sendMessage();
                  },
                  label: Localizations.localeOf(context).languageCode == "en"
                      ?"sent recommendation":"أرسال توصيه",
                ),
              ):
              Container(
                decoration: BoxDecoration(
                    color: mainColor,
                    shape: BoxShape.circle
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(

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
  Widget _buildCustomKeyboardToolbar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,

      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              _msgController.text += '\n'; // Add a newline
              _msgController.selection = TextSelection.collapsed(
                  offset: _msgController.text.length); // Move cursor to the end
            },
            child: Text(Localizations.localeOf(context).languageCode == "en"
                ?"Next Line":"السطر التالي"),
          ),
          ElevatedButton(
            onPressed: () {
              _msgNode.unfocus(); // Close the keyboard
            },
            child: Text(Localizations.localeOf(context).languageCode == "en"
                ?"Done":"تم"),
          ),
        ],
      ),
    );
  }
}
