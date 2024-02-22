import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayanSchool/I10n/AppLanguage.dart';
import 'package:rayanSchool/I10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

Widget changeLangPopUp(BuildContext context) {
  var appLanguage = Provider.of<AppLanguage>(context);
  return CupertinoActionSheet(
    title: new Text('${AppLocalizations.of(context).translate('language')}'),
    message:
        new Text('${AppLocalizations.of(context).translate('changeLanguage')}'),
    actions: <Widget>[
      CupertinoActionSheetAction(
        child: new Text('English'),
        onPressed: () {
          appLanguage.changeLanguage(Locale("en"));
          Navigator.pop(context);
        },
      ),
      CupertinoActionSheetAction(
        child: new Text('عربى'),
        onPressed: () {
          appLanguage.changeLanguage(Locale("ar"));
          Navigator.pop(context);
        },
      )
    ],
    cancelButton: CupertinoActionSheetAction(
      child: new Text('رجوع'),
      isDefaultAction: true,
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    ),
  );
}

////////////////////////////////////////////////
/// Page Navigation pages
////////////////////////////////////////////////
void popPage(BuildContext context) {
  Navigator.of(context).pop();
}

void pushPage(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void pushPageReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

////////////////////////////////////////////////
/// utilities
////////////////////////////////////////////////
bool emailvalidator(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

////////////////////////////////////////////////
////////////////////////////////////////////////

void showTheDialog(BuildContext context, String title, String body,
    {Widget extraAction}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      List<Widget> actions = [];
      actions.add(
        new FlatButton(
          child: new Text(AppLocalizations.of(context).translate('back')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
      if (extraAction != null) {
        actions.add(extraAction);
      }
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: new Text(title == null ? "" : title),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            children: <Widget>[
              new Text(body == null ? "" : body),
            ],
          ),
        ),
        actions: actions,
      );
    },
  );
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
