import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/globals/widgets/textFiled.dart';
import 'package:rayanSchool/services/authService.dart';
import 'package:rayanSchool/views/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool usernameError = false;
  bool passwordError = false;
  bool isServerLoading = false;
  String selectedType = "اختار نوع المستخدم";
  String accountType = "";

  validate() async {
    usernameError = usernameController.text.isEmpty;
    passwordError = passwordController.text.isEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "${AppLocalizations.of(context)?.translate('login')}",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/logoname.jpg"),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20)),
              Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText:
                    "${AppLocalizations.of(context)?.translate('userName')}",
                controller: usernameController,
              ),
              usernameError
                  ? Text(
                      "please enter your phone number",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText:
                    "${AppLocalizations.of(context)?.translate('password')}",
                controller: passwordController,
                inputType: TextInputType.text,
              ),
              passwordError
                  ? Text(
                      "please enter your password",
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 10)),
              Container(
                width: 200,
                height: 50,
                child: DropdownButton<String>(
                  icon: Container(),
                  value: selectedType,
                  items: <String>[
                    'اختار نوع المستخدم',
                    'ولي امر',
                    'مدرس',
                    'طالب',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    accountType = value == "ولي امر"
                        ? "PARENTS"
                        : value == "مدرس"
                            ? "TEACHER"
                            : "STUDENT";
                    selectedType = value!;
                    setState(() {});
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 35)),
              AppBtn(
                onClick: () async {
                  validate();
                  if (!passwordError && !usernameError) {
                    String msg = await AuthService().login(
                        password: passwordController.text,
                        userName: usernameController.text,
                        type: accountType);
                    if (msg == "done") {
                      pushPageReplacement(context, HomeScreen());
                    } else {
                      final snackBar = SnackBar(content: Text(msg));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }
                  }
                },
                label: "${AppLocalizations.of(context)?.translate('login')}",
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20))
            ],
          ),
        ));
  }
}
