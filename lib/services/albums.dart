import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:rayanSchool/models/AppInfo/photo.dart';
import 'package:rayanSchool/models/AppInfo/photoAlbum.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';

class AlbumsService {
  String photoAlbums = "${baseUrl}gallery.php";
  String videoAlbums = "${baseUrl}videos_gallery.php";

  Future<List<PhotoAlbum>?> getphotoAlbums() async {
    List<PhotoAlbum> list = [];
    Response response;
    response = await Dio().get(
      "$photoAlbums",
    );
    print("$photoAlbums");
    var data = response.data;
    if(data !=null) {
      data.forEach((element) {
        print(element.toString());
        list.add(PhotoAlbum.fromJson(element));
      });
    }
      return list;

  }

  Future<List<Videos>?> getVideoAlbums() async {
    List<Videos> list = [];
    Response response;
    response = await Dio().get(
      "$videoAlbums",
    );
    print("$videoAlbums");
    var data = response.data == null ? [] : response.data;
    if(data !=null) {
      data.forEach((element) {
        print(element.toString());

        list.add(Videos.fromJson(element));
      });
    }


    return list;
  }

  Future<List<Photo>> getphotoAlbum(String id) async {
    List<Photo> list = [];
    Response response;
    response = await Dio().get(
      "$photoAlbums?gid=$id",
    );
    print("$photoAlbums?gid=$id");
    var data = response.data;
    data.forEach((element) {
      list.add(Photo.fromJson(element));
    });
    return list;
  }

  Future<List<Videos>> getVideoAlbum(String id) async {
    List<Videos> list = [];
    Response response;
    response = await Dio().get(
      "https://www.alrayyanprivateschools.com/api/videos.php?gid=$id",
    );
    print("https://www.alrayyanprivateschools.com/api/videos.php?gid=$id");
    var data = response.data;
    data.forEach((element) {
      print(element.toString());
      list.add(Videos.fromJson(element));
    });
    return list;
  }
}
