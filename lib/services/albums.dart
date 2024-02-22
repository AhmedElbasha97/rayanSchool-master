import 'package:dio/dio.dart';
import 'package:rayanSchool/globals/CommonSetting.dart';
import 'package:rayanSchool/models/AppInfo/photo.dart';
import 'package:rayanSchool/models/AppInfo/photoAlbum.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';

class AlbumsService {
  String photoAlbums = "${baseUrl}gallery.php";
  String videoAlbums = "${baseUrl}videos.php";

  Future<List<PhotoAlbum>> getphotoAlbums() async {
    List<PhotoAlbum> list = [];
    Response response;
    response = await Dio().get(
      "$photoAlbums",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(PhotoAlbum.fromJson(element));
    });
    return list;
  }

  Future<List<Videos>> getVideoAlbums() async {
    List<Videos> list = [];
    Response response;
    response = await Dio().get(
      "$videoAlbums",
    );
    var data = response.data == null ? [] : response.data;
    data.forEach((element) {
      list.add(Videos.fromJson(element));
    });
    return list;
  }

  Future<List<Photo>> getphotoAlbum(String id) async {
    List<Photo> list = [];
    Response response;
    response = await Dio().get(
      "$photoAlbums?gid=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(Photo.fromJson(element));
    });
    return list;
  }

  Future<List<Photo>> getVideoAlbum(String id) async {
    List<Photo> list = [];
    Response response;
    response = await Dio().get(
      "$videoAlbums?gid=$id",
    );
    var data = response.data;
    data.forEach((element) {
      list.add(Photo.fromJson(element));
    });
    return list;
  }
}
