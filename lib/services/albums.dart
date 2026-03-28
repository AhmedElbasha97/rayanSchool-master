
import 'package:rayanSchool/models/AppInfo/photo.dart';
import 'package:rayanSchool/models/AppInfo/photoAlbum.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';

import '../Utils/api_service.dart';
import '../Utils/services.dart';

class AlbumsService {

  // Use the enhanced centralized ApiService
  final ApiService api = ApiService();

  Future<List<PhotoAlbum>?> getphotoAlbums() async {
    try {
      final data = await api.request(Services.photoAlbums,"GET");

      if (data is List) {
        return data
            .map((e) => PhotoAlbum.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getVideoAlbums error: $e");
      return [];
    }
  }
// Fetch video albums with enhanced error handling and logging
  Future<List<Videos>?> getVideoAlbums() async {
    try {
      final data = await api.request(Services.videoAlbums,"GET");

      if (data is List) {
        return data
            .map((e) => Videos.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getVideoAlbums error: $e");
      return [];
    }

  }
// Fetch photos for a specific album with enhanced error handling and logging
  Future<List<Photo>> getphotoAlbum(String id) async {  try {
    final data = await api.request(Services.photoAlbums,"GET",queryParameters: {
      "gid":id
    });

    if (data is List) {
      return data
          .map((e) => Photo.fromJson(e))
          .toList();
    } else {
      print("⚠ Unexpected data format: $data");
      return [];
    }
  } catch (e) {
    print("❌ getphotoAlbum error: $e");
    return [];
  }

  }
// Fetch videos for a specific album with enhanced error handling and logging
  Future<List<Videos>> getVideoAlbum(String id) async {

    try {
      final data = await api.request(Services.videoAlbums2,"GET",queryParameters: {
        "gid":id
      });

      if (data is List) {
        return data
            .map((e) => Videos.fromJson(e))
            .toList();
      } else {
        print("⚠ Unexpected data format: $data");
        return [];
      }
    } catch (e) {
      print("❌ getVideoAlbum error: $e");
      return [];
    }

  }
}
