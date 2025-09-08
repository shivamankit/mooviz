import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/datasources/models/movie.dart';
import '../../modules/bookmarks/viewmodel/bookmarks_controller.dart';
import '../constants/app_constants.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.bookmarksController,
    required this.movies,
  });

  final BookmarksController bookmarksController;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 220,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Container(
          width: 140,
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl:
                  "${AppConstants.IMAGE_BASE_URL}${movie.posterPath}",
                  placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              Obx(() {
                final isBookmarked =
                bookmarksController.isBookmarked(movie.id);
                return IconButton(
                  icon: Icon(
                    isBookmarked.value
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: isBookmarked.value
                        ? Colors.amber
                        : Colors.white,
                  ),
                  onPressed: () {
                    if (isBookmarked.value) {
                      bookmarksController.removeBookmark(movie.id);
                    } else {
                      bookmarksController.addBookmark(movie);
                    }
                  },
                );
              }),
              Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    ),
  );
}