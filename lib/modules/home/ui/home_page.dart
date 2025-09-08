import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mooviz/modules/bookmarks/viewmodel/bookmarks_controller.dart';
import 'package:mooviz/core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/movie_list.dart';
import '../../../core/widgets/section_title.dart';
import '../../../data/datasources/models/movie.dart';
import '../viewmodel/home_controller.dart';

// home_page.dart
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.find<HomeController>();
  final bookmarksController = Get.find<BookmarksController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyText,
      body: Obx(() {
        if (controller.isInitialLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value!,
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.refreshAll,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshAll,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: "Trending"),
                MovieList(bookmarksController: bookmarksController, movies: controller.trending),
                SectionTitle(title: "Now Playing"),
                MovieList(bookmarksController: bookmarksController, movies: controller.nowPlaying),
              ],
            ),
          ),
        );
      }),
    );
  }
}



