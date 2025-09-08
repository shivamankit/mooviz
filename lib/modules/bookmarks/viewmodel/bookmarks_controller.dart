import 'package:get/get.dart';
import '../../../data/datasources/models/movie.dart';
import '../../../data/repositories/movie_repository.dart';

class BookmarksController extends GetxController {
  final MovieRepository repository;

  BookmarksController({required this.repository});

  var bookmarks = <Movie>[].obs;
  var bookmarkedIds = <int>{}.obs; // <-- reactive set of bookmarked IDs

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  void loadBookmarks() {
    final list = repository.getBookmarks();
    bookmarks.assignAll(list);

    // update ids set also
    bookmarkedIds
      ..clear()
      ..addAll(list.map((m) => m.id));
  }

  Future<void> addBookmark(Movie movie) async {
    await repository.bookmarkMovie(movie);
    loadBookmarks();
  }

  Future<void> removeBookmark(int id) async {
    await repository.removeBookmark(id);
    loadBookmarks();
  }

  /// Reactive observable for UI
  RxBool isBookmarked(int id) {
    return (bookmarkedIds.contains(id)).obs;
  }
}
