import 'package:flutter/material.dart';
import 'package:rayanSchool/models/Student/book.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksScreen extends StatefulWidget {
  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  bool isLoading = true;
  List<Books>? books = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    books = await LoggedUser().getBooks(id: id);
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
          : books?.isEmpty??true?
      Container(
        height: MediaQuery.of(context).size.height*0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/noBooks.png"),
            ),
            SizedBox(height: 20,),
            Text(Localizations.localeOf(context).languageCode == "en"
                ?"no books available":"لا يوجد كتب متوفره لان",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20

              ),),
          ],
        ),
      ):ListView.separated(
              itemCount: books?.length??0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () async {
                      if (await canLaunch("${books?[index].file}")) {
                        await launch("${books?[index].file}");
                      } else {
                        throw 'Could not launch ${books?[index].file}';
                      }
                    },
                    title: Text("${books?[index].title}"),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
    );
  }
}
