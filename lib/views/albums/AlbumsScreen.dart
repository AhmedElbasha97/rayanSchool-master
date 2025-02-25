import 'package:flutter/material.dart';
import 'package:rayanSchool/globals/helpers.dart';
import 'package:rayanSchool/models/AppInfo/photoAlbum.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';
import 'package:rayanSchool/services/albums.dart';
import 'package:rayanSchool/views/other/photosAlbum.dart';
import 'package:url_launcher/url_launcher.dart';

class AlbumsScreen extends StatefulWidget {
 final bool isImg;
  AlbumsScreen({this.isImg = true});
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  bool isLoading = true;
  List<PhotoAlbum>? list = [];
  List<Videos>? listVideos = [];
  bool isEmptyList = false;
  getData() async {
    if (widget.isImg) {
      list = await AlbumsService().getphotoAlbums();
      if(list?.isEmpty??true){
        isEmptyList = true;
      }
    } else {
      listVideos = await AlbumsService().getVideoAlbums();
      if(listVideos?.isEmpty??true){
        isEmptyList = true;
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (isEmptyList)? Container(
          height: MediaQuery.of(context).size.height*0.35,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/images/noData.png"),
              ),
              SizedBox(height: 20,),
              Text(widget.isImg?Localizations.localeOf(context).languageCode == "en"
                  ?"no Photos available":"لا يوجد ألبوم الصور متوفرة الآن":Localizations.localeOf(context).languageCode == "en"
                  ?"no Videos available":"لا يوجد ألبوم الفيديو متوفرة الآن",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20

                ),),
            ],
          ),
        ):

       ListView.builder(
                itemCount: widget.isImg ? list?.length??0 : listVideos?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          if (widget.isImg) {
                            pushPage(
                                context,
                                PhotosAlbum(
                                  id: list?[index].id??"",
                                  isImg: widget.isImg,
                                  title: list?[index].title??"",
                                ));
                          } else {
                            pushPage(
                                context,
                                PhotosAlbum(
                                  id: listVideos?[index].id??"",
                                  isImg: widget.isImg,
                                  title: listVideos?[index].title??"",
                                ));

                            }
                          },


                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${widget.isImg ? (list?[index].img??"") : (listVideos?[index].img??"")}"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 200,
                                  child: Text(
                                    "${widget.isImg ? (list?[index].title??"") : (listVideos?[index].title??"")}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
    )
    );
                }
    )
    );
  }
  }

