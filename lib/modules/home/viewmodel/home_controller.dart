import 'package:get/get.dart';
import '../../../data/datasources/models/movie.dart';
import '../../../data/repositories/movie_repository.dart';

class HomeController extends GetxController {
  final MovieRepository repository;

  HomeController({required this.repository});

  var trending = <Movie>[].obs;
  var nowPlaying = <Movie>[].obs;

  var isLoading = false.obs;
  var isInitialLoading = true.obs;
  var error = RxnString();

  @override
  void onInit() {
    super.onInit();
    trending.bindStream(repository.listenTrending());
    nowPlaying.bindStream(repository.listenNowPlaying());
    refreshAll();
  }

  Future<void> refreshAll() async {
    try {
      if (trending.isEmpty && nowPlaying.isEmpty) {
        isInitialLoading.value = true;
      }
      isLoading.value = true;

      await Future.wait([
        repository.refreshTrending(),
        repository.refreshNowPlaying(),
      ]);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
      isInitialLoading.value = false;
    }
  }
}