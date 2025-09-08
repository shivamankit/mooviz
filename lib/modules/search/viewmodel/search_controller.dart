import 'package:get/get.dart';

import '../../../data/datasources/models/movie.dart';
import '../../../data/repositories/movie_repository.dart';

class SearchController extends GetxController {
  final MovieRepository repository;

  SearchController({required this.repository});

  var results = <Movie>[].obs;
  var isLoading = false.obs;
  var error = RxnString();
  var query = ''.obs;

  String? _lastQuery;

  @override
  void onInit() {
    super.onInit();

    // Debounce query changes
    debounce(query, (value) {
      final q = query.value.trim();
      if (q.isNotEmpty) {
        // Avoid duplicate API calls for same query
        if (_lastQuery != q) {
          search(q);
        }
      } else {
        clearResults();
      }
    }, time: const Duration(milliseconds: 500));
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return;

    _lastQuery = query;
    isLoading.value = true;
    error.value = null;

    try {
      final movies = await repository.searchMovies(query);
      if (movies.isEmpty) {
        results.clear();
        error.value = "No results found for \"$query\"";
      } else {
        results.assignAll(movies);
      }
    } catch (e) {
      error.value = e.toString();
      results.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void clearResults() {
    _lastQuery = null;
    results.clear();
    error.value = null;
  }
}
