import 'package:flutter/material.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:rayanSchool/globals/commonStyles.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/globals/widgets/mainButton.dart';
import 'package:rayanSchool/globals/widgets/textFiled.dart';
import 'package:rayanSchool/services/authService.dart';
import 'package:rayanSchool/views/homeScreen.dart';

import '../../services/teachersService.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController NewPasswordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool usernameError = false;
  bool passwordError = false;
  bool isServerLoading = false;


  validate() async {
    usernameError = oldPasswordController.text.isEmpty;
    passwordError = NewPasswordController.text.isEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "${AppLocalizations.of(context)?.translate('changePass')}",
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
                child: Image.asset("assets/images/logoname.png"),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20)),
              Padding(padding: EdgeInsets.only(top: 10)),
              InputFiled(
                hintText:
                "${AppLocalizations.of(context)?.translate('oldPass')}",
                controller: oldPasswordController,
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
                "${AppLocalizations.of(context)?.translate('newPass')}",
                controller: NewPasswordController,
                inputType: TextInputType.text,
              ),
              passwordError
                  ? Text(
                "please enter your password",
                style: TextStyle(color: Colors.red),
              )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 35)),
              !isServerLoading? AppBtn(
                onClick: () async {
                  if(!isServerLoading){
                    setState(() {
                      isServerLoading = true;
                    });
                    validate();
                    if (!passwordError && !usernameError) {
                      String msg = await AuthService().changePassword(
                        newPass:NewPasswordController.text,
                      oldPass: oldPasswordController.text);
                      if (msg == "done") {
                        setState(() {
                          isServerLoading = false;
                        });
                        pushPageReplacement(context, HomeScreen());
                      } else {
                        setState(() {
                          isServerLoading = false;
                        });
                        final snackBar = SnackBar(content: Text(msg));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      }
                    }
                  }
                },
                label: "${AppLocalizations.of(context)?.translate('changePass')}",
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
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20))
            ],
          ),
        ));
  }
}
