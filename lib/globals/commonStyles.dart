import 'package:flutter/material.dart';

///////////////////////////////////////////////////////////
/// Colors
///////////////////////////////////////////////////////////
Color mainColor = Color(0xFFE8A20D);
Color mainTextColor = Color(0xFF0c1f38);
Color accent = Colors.cyan;
Color textColor = Color(0xFF303030);
Color smallTextColor = Color(0xFF929292);
Color splash = Colors.blue;

///////////////////////////////////////////////////////////
/// theme
///////////////////////////////////////////////////////////
ThemeData appTheme = ThemeData(
    appBarTheme: appBarTheme,
    brightness: appBrightness,
    fontFamily: "DroidKufi");

Brightness appBrightness = Brightness.light;

AppBarTheme appBarTheme = AppBarTheme(
  color: accent,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  elevation: 0.0,
);

///////////////////////////////////////////////////////////
/// Text Styles
///////////////////////////////////////////////////////////
TextStyle appText =
    TextStyle(color: textColor, fontWeight: FontWeight.w300, fontSize: 15);
TextStyle appBarAccent =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20);

TextStyle buttonStyleMain = TextStyle(color: textColor, fontSize: 20);
TextStyle buttonStyleAccent = TextStyle(color: accent, fontSize: 20);

///////////////////////////////////////////////////////////
/// Applinks
///////////////////////////////////////////////////////////
String androidStoreLink = "";
String iosStoreLink = "";
