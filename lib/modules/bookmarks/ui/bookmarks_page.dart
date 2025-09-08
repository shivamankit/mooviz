import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/bookmarks_controller.dart';

class BookmarksPage extends StatelessWidget {
  final BookmarksController controller = Get.find<BookmarksController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks")),
      body: Obx(() {
        if (controller.bookmarks.isEmpty) {
          return const Center(child: Text("No bookmarks yet"));
        }
        return ListView.builder(
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            final movie = controller.bookmarks[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                width: 50,
                fit: BoxFit.cover,
                placeholder: (ctx, url) =>
                const SizedBox(width: 50, child: Center(child: CircularProgressIndicator())),
                errorWidget: (ctx, url, error) =>
                const Icon(Icons.error, size: 40),
              ),
              title: Text(movie.title),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => controller.removeBookmark(movie.id),
              ),
            );
          },
        );
      }),
    );
  }
}
