import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/commonStyles.dart';

class InputFiled extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  InputFiled(
      {this.controller, this.hintText, this.inputType = TextInputType.text});
  @override
  _InputFiledState createState() => _InputFiledState();
}

class _InputFiledState extends State<InputFiled> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        keyboardType: widget.inputType,
        controller: widget.controller,
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: mainColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: mainColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: mainColor)),
            hintText: widget.hintText),
      ),
    );
  }
}
