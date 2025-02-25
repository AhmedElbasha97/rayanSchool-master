import 'package:flutter/material.dart';
import 'package:rayanSchool/models/AppInfo/photo.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';
import 'package:rayanSchool/services/albums.dart';

import '../../globals/helpers.dart';

class PhotosAlbum extends StatefulWidget {
  final String? id;
  final String? title;
  final bool isImg;
  PhotosAlbum({this.id, this.title, this.isImg = true});
  @override
  _PhotosAlbumState createState() => _PhotosAlbumState();
}

class _PhotosAlbumState extends State<PhotosAlbum> {
  bool isLoading = true;
  List<Photo> list = [];
  List<Videos> listVideos = [];

  getData() async {
    if (widget.isImg) {
      list = await AlbumsService().getphotoAlbum(widget.id??"");
    }else{
      listVideos = await AlbumsService().getVideoAlbum(widget.id??"");
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
        appBar: AppBar(
          title: Text("${widget.title}"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: widget.isImg ? list.length : listVideos.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      if (widget.isImg){
                      }else{
                        print(listVideos[index].link??"");
                        launchURL(listVideos[index].link??"");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("${widget.isImg ? list[index].img:listVideos[index].img}"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  );
                }));
  }
}
