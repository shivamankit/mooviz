import '../datasources/models/movie.dart';
import '../datasources/local/hive_service.dart';
import '../datasources/remote/movie_api_service.dart';

class MovieRepository {
  final MovieApiService api;
  final HiveService hive;

  MovieRepository({required this.api, required this.hive});

  // ---------------- Trending ----------------
  Future<List<Movie>> fetchTrending() async {
    final local = hive.trendingBox.values.toList();
    refreshTrending();
    return local;
  }
  Stream<List<Movie>> listenTrending() {
    return hive.trendingBox.watch().map((_) => hive.trendingBox.values.toList());
  }

  Future<void> refreshTrending() async {
    try {
      final response = await api.getTrending();
      final fresh = response.results;

      await hive.trendingBox.clear();
      for (var movie in fresh) {
        await hive.trendingBox.put(movie.id, movie);
      }
    } catch (e) {
      print("Error in refreshTrending: $e");
    }
  }

  // ---------------- Now Playing ----------------
  Future<List<Movie>> fetchNowPlaying() async {
    final local = hive.nowPlayingBox.values.toList();
    refreshNowPlaying();
    return local;
  }

  Stream<List<Movie>> listenNowPlaying() {
    return hive.nowPlayingBox.watch().map((_) => hive.nowPlayingBox.values.toList());
  }

  Future<void> refreshNowPlaying() async {
    try {
      final response = await api.getNowPlaying();
      final fresh = response.results;

      await hive.nowPlayingBox.clear();
      for (var movie in fresh) {
        await hive.nowPlayingBox.put(movie.id, movie);
      }
    } catch (e) {
      print("Error in refreshNowPlaying: $e");
    }
  }

  // ---------------- Search ----------------
  Future<List<Movie>> searchMovies(String query) async {
    final local = hive.searchBox.values.toList();
    _refreshSearch(query);
    return local;
  }

  Future<void> _refreshSearch(String query) async {
    try {
      final response = await api.searchMovies(query);
      final results = response.results;

      await hive.searchBox.clear();
      for (var movie in results) {
        await hive.searchBox.put(movie.id, movie);
      }
    } catch (e) {
      print("Error in refreshSearch: $e");
    }
  }

  // ---------------- Bookmarks ----------------
  Future<void> bookmarkMovie(Movie movie) async {
    await hive.bookmarksBox.put(movie.id, movie);
  }

  Future<void> removeBookmark(int id) async {
    await hive.bookmarksBox.delete(id);
  }

  List<Movie> getBookmarks() {
    return hive.bookmarksBox.values.toList();
  }

  bool isBookmarked(int id) {
    return hive.bookmarksBox.containsKey(id);
  }

  // ---------------- Movie Details ----------------
  Future<Movie?> fetchMovieDetails(int id) async {
    final local = hive.movieDetailsBox.get(id);
    _refreshMovieDetail(id);
    return local;
  }

  Future<Movie?> refreshMovieDetails(int id) async {
    try {
      final response = await api.getMovieDetails(id);

      final movie = Movie(
        id: response.id,
        title: response.title,
        posterPath: response.posterPath,
        overview: response.overview,
        releaseDate: response.releaseDate,
        voteAverage: response.voteAverage,
      );

      await hive.movieDetailsBox.put(id, movie);
      return movie;
    } catch (e) {
      print("Error in refreshMovieDetails: $e");
      return hive.movieDetailsBox.get(id);
    }
  }

  Future<void> _refreshMovieDetail(int id) async {
    try {
      await refreshMovieDetails(id);
    } catch (_) {}
  }
}