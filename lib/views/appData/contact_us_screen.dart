import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/services/contactUsService.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _msgController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  FocusNode _emailNode = new FocusNode();
  FocusNode _nameNode = new FocusNode();
  FocusNode _msgNode = new FocusNode();
  FocusNode _phoneNode = new FocusNode();

  bool emailvalidator(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  sendMessage() async {
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      await ContactUsService().sendComplain(
          _nameController.text,
          _msgController.text,
          _emailController.text,
          "",
          _phoneController.text);
      isLoading = false;
      setState(() {});
      popPage(context);
    }
  }

  void unFocus() {
    _emailNode.unfocus();
    _nameNode.unfocus();
    _msgNode.unfocus();
    _phoneNode.unfocus();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${AppLocalizations.of(context)?.translate('callUs')??''}",
          ),
          automaticallyImplyLeading: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  AppLocalizations.of(context)?.translate('complaientMsg')??"",
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
                  focusNode: _nameNode,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.people),
                    counterText: "",
                    hintText: AppLocalizations.of(context)?.translate('name')??"",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 1) {
                      return AppLocalizations.of(context)
                          ?.translate('nameError')??"";
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
                  focusNode: _phoneNode,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    counterText: "",
                    hintText:
                        AppLocalizations.of(context)?.translate('phoneNumber')??"",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 1) {
                      return AppLocalizations.of(context)
                          ?.translate('phoneError')??"";
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
                  focusNode: _emailNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    counterText: "",
                    hintText: AppLocalizations.of(context)?.translate('email')??"",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == "" || emailvalidator(value!) == false) {
                      return AppLocalizations.of(context)
                          ?.translate('emailError')??"";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  validator: (value) {
                    if (value!.length < 2) {
                      return AppLocalizations.of(context)
                          ?.translate('MessageError')??"";
                    }
                    return null;
                  },
                  focusNode: _msgNode,
                  controller: _msgController,
                  maxLines: 4,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)?.translate('typeMsg')??"",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF184e7a), width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )),
              SizedBox(
                height: 15,
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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
