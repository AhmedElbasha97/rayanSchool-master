import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rayanSchool/models/AppInfo/aboutSchool.dart';
import 'package:rayanSchool/services/appInfoService.dart';

class SchoolWord extends StatefulWidget {
  final bool isAbout;
  SchoolWord({this.isAbout = false});
  @override
  _SchoolWordState createState() => _SchoolWordState();
}

class _SchoolWordState extends State<SchoolWord> {
  AboutSchool? word;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    word = widget.isAbout
        ? await AppInfoService().getAboutSchool()
        : await AppInfoService().getSchoolWord();
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${word?.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(data: word?.description),
                )
              ],
            ),
    );
  }
}
