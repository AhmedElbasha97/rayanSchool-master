import 'package:get/get.dart';
import 'package:rayanSchool/models/Student/book.dart';
import 'package:rayanSchool/services/loggedUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Utils/memory.dart';

class BooksController extends GetxController {
  var isLoading = true.obs;
  RxList<Books>? books = <Books>[].obs;

  /// Fetch books list for the logged-in student
  Future<void> fetchBooks() async {
    try {
      isLoading.value = true;
      final data = await LoggedUser().getBooks(id: Get.find<StorageService>().getId);
      books?.assignAll(data != null?data:[]);
    } catch (e) {
      print("Error fetching books: $e");
      books?.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Open the book's URL in the browser
  Future<void> openBook(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not launch book",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }
}
