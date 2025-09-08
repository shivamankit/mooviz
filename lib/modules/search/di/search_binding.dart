import 'package:get/get.dart';

import '../../../data/repositories/movie_repository.dart';
import '../viewmodel/search_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController(repository: Get.find<MovieRepository>(),), fenix: true);
  }

}