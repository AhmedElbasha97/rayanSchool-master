// controllers/photos_album_controller.dart
import 'package:get/get.dart';
import 'package:rayanSchool/models/AppInfo/photo.dart';
import 'package:rayanSchool/models/AppInfo/videos.dart';
import 'package:rayanSchool/services/albums.dart';

class PhotosAlbumController extends GetxController {
  final String albumId;
  final bool isImg;

  PhotosAlbumController({
    required this.albumId,
    required this.isImg,
  });

  final isLoading = true.obs;
  final photos = <Photo>[].obs;
  final videos = <Videos>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      if (isImg) {
        photos.assignAll(await AlbumsService().getphotoAlbum(albumId));
      } else {
        videos.assignAll(await AlbumsService().getVideoAlbum(albumId));
      }
    } finally {
      isLoading.value = false;
    }
  }
}
