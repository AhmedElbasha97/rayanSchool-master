import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/teachers.dart';
import 'package:rayanSchool/services/messagesService.dart';
import 'package:rayanSchool/services/teachersService.dart';
import 'package:rayanSchool/views/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMessageStudentScreen extends StatefulWidget {
  @override
  _SendMessageStudentScreenState createState() =>
      _SendMessageStudentScreenState();
}

class _SendMessageStudentScreenState extends State<SendMessageStudentScreen> {
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _msgController = new TextEditingController();

  FocusNode _titleNode = new FocusNode();
  FocusNode _msgNode = new FocusNode();

  String type = 'اختار المرسل له';
  String selected = "";
  List<Teachers> teachers = [];
  Teachers selectedTeacher;
  Teachers selectTeacher = Teachers(name: "اختر مدرس");

  @override
  void initState() {
    super.initState();
    getTeachers();
  }

  getTeachers() async {
    isLoading = true;
    setState(() {});
    teachers = await MessagesService().getTeacher();
    teachers.add(selectTeacher);
    isLoading = false;
    setState(() {});
  }

  sendMessage() async {
    if (_formKey.currentState.validate()) {
      isLoading = true;
      setState(() {});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("id");
      String done = await TeacherService().sendMessages(id:id);
      isLoading = false;
      setState(() {});
      if (done == "true") {
        pushPageReplacement(context, HomeScreen());
      } else {
        final snackBar = SnackBar(content: Text(done));
        scaffoldKey.currentState.showSnackBar(snackBar);
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
                      child: Text(
                        AppLocalizations.of(context).translate('sendMessage'),
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
                        focusNode: _titleNode,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.message),
                          counterText: "",
                          hintText:
                              AppLocalizations.of(context).translate('title'),
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
                          if (value.length < 1) {
                            return AppLocalizations.of(context)
                                .translate('titleError');
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
                              AppLocalizations.of(context).translate('message'),
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
                          if (value.length < 1) {
                            return AppLocalizations.of(context)
                                .translate('MessageError');
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
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          type = value;
                          selected = type == 'مدرس' ? "teacher" : "admin";
                          setState(() {});
                        },
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      child: selected == "admin"
                          ? Container()
                          : DropdownButton<Teachers>(
                              icon: Container(),
                              value: selectTeacher,
                              items: teachers.map((Teachers value) {
                                return DropdownMenuItem<Teachers>(
                                  value: value,
                                  child: Text("${value.name}"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectTeacher = value;
                                selectedTeacher = value;
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
                              AppLocalizations.of(context).translate('send'),
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
