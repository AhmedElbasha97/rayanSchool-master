import 'package:flutter/material.dart';

import '../../I10n/app_localizations.dart';
import '../../globals/commonStyles.dart';
import '../../globals/helpers.dart';
import '../../globals/widgets/mainButton.dart';
import '../../models/teacher/category.dart';
import '../../services/teachersService.dart';
import '../myAccountTeacher.dart';

class AddHomeWorkScreen extends StatefulWidget {
  const AddHomeWorkScreen({Key? key}) : super(key: key);

  @override
  _AddHomeWorkScreenState createState() => _AddHomeWorkScreenState();
}

class _AddHomeWorkScreenState extends State<AddHomeWorkScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _msgController = new TextEditingController();
  FocusNode _msgNode = new FocusNode();
  TextEditingController _titleController = new TextEditingController();
  FocusNode _titleNode = new FocusNode();

  List<Category> categories = [];
  List<Category> levels = [];
  List<Category> levels2 = [];

  bool isLoading = false;
  bool recommendationIsLoading = true;
  bool categoryloading = true;
  bool levelLoading = false;

  bool level2Loading = false;
  bool studentsLoading = false;

  Category selectCatogory = Category(ctgName: "اختار القسم");
  Category selectLevel = Category(ctgName: "اختار المرحلة");
  Category selectLevel2 = Category(ctgName: "اختار الفصل");
  List<Map<String?,String?>> recommendationList =[];
  Category? selectedCatogory;
  Category? selectedLevel;

  Category? selectedLevel2;
  bool isServerLoading = false;
  String recommendationTitle = "";
  String recommendationValue = "";
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


  void unFocus() {
    _msgNode.unfocus();
    setState(() {});
  }

  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      if (selectedLevel2 != null) {
        if(!isServerLoading){
          setState(() {
            isServerLoading = true;
          });

          String msg =   await TeacherService().addHomeWork(classId: selectedLevel2?.id??"",details: _msgController.text,title: _titleController.text);
          if (msg == "done") {
            setState(() {
              isServerLoading = false;
            });
            final snackBar = SnackBar(content:
            Row(children: [
              Icon(Icons.check,color: Colors.white,),
              SizedBox(width: 10,),
              Text(Localizations.localeOf(context).languageCode == "en" ?'Homework has been added successfully':'تم أضافه الواجب المنزلى  بنجاح',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              ),
            ],),
                backgroundColor:Colors.green
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            pushPageReplacement(context, MyAccountTeacher());
          } else {
            setState(() {
              isServerLoading = false;
            });
            final snackBar = SnackBar(content:
            Row(children: [
              Icon(Icons.close,color: Colors.white,),
              SizedBox(width: 10,),
              Text(Localizations.localeOf(context).languageCode == "en" ?'Try adding homework again':'حاول أضافه الواجب المنزلى مره اخرى',style: TextStyle(
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
        appBar: AppBar(
          title: Text(Localizations.localeOf(context).languageCode == "en"
              ?"add HomeWork":"أضافه واجب منزلى"),
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
                    ?"Choose the class:":"أختر الفصل :",
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
                          _titleNode.requestFocus();

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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    maxLines: 1,
                    onSaved: (e){
                      if(e!=null){
                        _titleNode.unfocus();
                        _msgNode.requestFocus();
                      }
                    },
                    focusNode: _titleNode,
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.message_rounded),
                      counterText: "",
                      hintText: Localizations.localeOf(context).languageCode == "en"
                          ?"HomeWork Title":"عنوان واجب منزلى",
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

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    maxLines: 4,
                    focusNode: _msgNode,
                    controller: _msgController,
                    keyboardType: TextInputType.multiline,
                    onSaved: (e){
                      if(e!=null){
                        _msgNode.unfocus();
                      }
                    },
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
                      ?"add HomeWork":"أضافه واجب منزلى",
                ),
              ):Container(
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
}
