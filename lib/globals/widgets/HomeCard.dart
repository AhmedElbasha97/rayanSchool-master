import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/widgets/UICard.dart';

class HomeCard extends StatefulWidget {
  final Function onTap;
  final String title;
  final String imageLink;
  final double width;
  HomeCard({this.imageLink, this.onTap, this.title, this.width = 130});
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: widget.width,
        height: 100,
        child: InkWell(
          onTap: widget.onTap,
          child: UICard(
            cardContent: Container(
              height: 80,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: Image.asset("${widget.imageLink}"),
                  ),
                  Container(child: Text("${widget.title}"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
