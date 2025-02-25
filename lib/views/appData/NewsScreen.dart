import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/AppInfo/News.dart';
import 'package:rayanSchool/services/appInfoService.dart';

import 'NewsDetailsScreen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
    bool isLoading = true;
  List<News>? news = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    news = await AppInfoService().getNews();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : news?.isEmpty??true?
        Container(
          height: MediaQuery.of(context).size.height*0.75,
          width: MediaQuery.of(context).size.width,
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/images/noData.png"),
              ),
              SizedBox(height: 20,),
              Text(Localizations.localeOf(context).languageCode == "en"
                  ?"no News available":"لا يوجد أخبار متوفرة الآن",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20

                ),),
            ],
          ),
        ):ListView.separated(
                itemCount: news?.length??0,
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pushPage(
                            context,
                            NewsDetailsScreen(
                              id: news?[index].id??"",
                            ));
                      },
                      child: ListTile(
                        title: Text("${news?[index].title??""}"),
                        subtitle: Text("${news?[index].brief??""}"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ));
  }
}