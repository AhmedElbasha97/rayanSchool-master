import 'package:get/get.dart';
import '../../../models/AppInfo/photoAlbum.dart';
import '../../../models/AppInfo/videos.dart';
import '../../../services/albums.dart';


class AlbumsController extends GetxController {
  var isLoading = true.obs;
  var isEmptyList = false.obs;

  RxList<PhotoAlbum>? list = <PhotoAlbum>[].obs;
  RxList<Videos>? listVideos = <Videos>[].obs;

  Future<void> getData(bool isImg) async {
    isLoading.value = true;
    isEmptyList.value = false;

    if (isImg) {
      var data = await AlbumsService().getphotoAlbums();
      if(data?.isNotEmpty??false) {
        list?.assignAll(data!);
      }
      if (list?.isEmpty??true) isEmptyList.value = true;
    } else {
      var data = await AlbumsService().getVideoAlbums();
      if(data?.isNotEmpty??false) {
        listVideos?.assignAll(data!);
      }
      if (listVideos?.isEmpty??true) isEmptyList.value = true;
    }

    isLoading.value = false;
  }
}