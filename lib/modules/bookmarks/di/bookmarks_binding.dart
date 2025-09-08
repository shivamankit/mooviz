import 'package:get/get.dart';

import '../../../data/repositories/movie_repository.dart';
import '../viewmodel/bookmarks_controller.dart';

class BookmarksBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BookmarksController>(() => BookmarksController(repository: Get.find<MovieRepository>(),), fenix: true);
  }

}