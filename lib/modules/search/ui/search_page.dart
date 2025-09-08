import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/search_controller.dart'as myAppSearchController;

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final controller = Get.find<myAppSearchController.SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Movies"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search TextField
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => controller.query.value = value,
                decoration: InputDecoration(
                  hintText: "Search movies...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Body
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.value != null) {
                  return Center(child: Text("Error: ${controller.error.value}"));
                }

                if (controller.results.isEmpty) {
                  return const Center(child: Text("No results"));
                }

                // Results list
                return ListView.builder(
                  itemCount: controller.results.length,
                  itemBuilder: (context, index) {
                    final movie = controller.results[index];
                    return ListTile(
                      leading: movie.posterPath != null
                          ? Image.network(
                        "https://image.tmdb.org/t/p/w92${movie.posterPath}",
                        fit: BoxFit.cover,
                        width: 50,
                      )
                          : const Icon(Icons.movie),
                      title: Text(movie.title),
                      subtitle: Text(movie.releaseDate ?? ""),
                      onTap: () {
                        // TODO: Navigate to movie details page
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
