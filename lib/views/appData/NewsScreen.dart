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
  List<News> news = [];
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
            : ListView.separated(
                itemCount: news.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pushPage(
                            context,
                            NewsDetailsScreen(
                              id: news[index].id,
                            ));
                      },
                      child: ListTile(
                        title: Text("${news[index].title}"),
                        subtitle: Text("${news[index].brief}"),
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