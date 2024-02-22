import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/widgets/UICard.dart';

class HomeWorkCard extends StatefulWidget {
  final String date;
  final String teacherName;
  final String title;
  HomeWorkCard({this.date = "", this.title = "", this.teacherName = ""});
  @override
  _HomeWorkCardState createState() => _HomeWorkCardState();
}

class _HomeWorkCardState extends State<HomeWorkCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: UICard(
          cardContent: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Text("${widget.title}")),
                Container(child: Text("${widget.date}")),
                Container(child: Text("${widget.teacherName}"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
