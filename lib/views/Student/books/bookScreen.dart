import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayanSchool/Widgets/loader.dart';
import '../../../globals/commonStyles.dart';
import 'controller/book_controller.dart';

class BooksScreen extends StatelessWidget {
  BooksScreen({Key? key}) : super(key: key);

  final BooksController controller = Get.put(BooksController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    // Fetch books when screen loads
    controller.fetchBooks();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: const Color(0xFFdcdbdb),
        title: Image.asset(
          "assets/images/logo.png",
          scale: 4.5,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        // Show loader while fetching data
        if (controller.isLoading.value) {
          return Loader();
        }
        // Show empty state if no books are available
        if (controller.books?.isEmpty??true) {
          return Container(
            height: Get.height * 0.75,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/images/noBooks.png"),
                ),
                const SizedBox(height: 20),
                Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? "No books available"
                      : "لا يوجد كتب متوفرة الآن",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
        // Display the books using ListView.builder
        return ListView.separated(
          itemCount: controller.books?.length??0,
          itemBuilder: (BuildContext context, int index) {
            final book = controller.books?[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => controller.openBook(book?.file ?? ""),
                title: Text("${book?.title}"),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      }),
    );
  }
}
