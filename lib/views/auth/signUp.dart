import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/globals/widgets/textFiled.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool nameError = false;
  bool emailError = false;
  bool phoneError = false;
  bool passwordError = false;

  validate() async {
    nameError = nameController.text.isEmpty;
    emailError = emailController.text.isEmpty;
    phoneError = phoneController.text.isEmpty;
    passwordError = passwordController.text.isEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "${AppLocalizations.of(context).translate('signUp')}",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20)),
              Image.asset("assets/images/logoname.jpg"),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20)),
              InputFiled(
                hintText: "${AppLocalizations.of(context).translate('name')}",
                controller: nameController,
                inputType: TextInputType.text,
              ),
              nameError
                  ? Text(
                      "please enter your name",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText: "${AppLocalizations.of(context).translate('email')}",
                controller: emailController,
                inputType: TextInputType.emailAddress,
              ),
              emailError
                  ? Text(
                      "please enter your email",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText:
                    "${AppLocalizations.of(context).translate('phoneNumber')}",
                controller: phoneController,
                inputType: TextInputType.phone,
              ),
              phoneError
                  ? Text(
                      "please enter your phone number",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText:
                    "${AppLocalizations.of(context).translate('password')}",
                controller: passwordController,
                inputType: TextInputType.text,
              ),
              passwordError
                  ? Text(
                      "please enter your password",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 35)),
              AppBtn(
                onClick: () {
                  validate();
                },
                label: "${AppLocalizations.of(context).translate('login')}",
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20))
            ],
          ),
        ));
  }
}
