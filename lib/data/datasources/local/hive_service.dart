import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  late Box<Movie> trendingBox;
  late Box<Movie> nowPlayingBox;
  late Box<Movie> searchBox;
  late Box<Movie> bookmarksBox;
  late Box<Movie> movieDetailsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieAdapter());

    trendingBox = await Hive.openBox<Movie>('trendingBox');
    nowPlayingBox = await Hive.openBox<Movie>('nowPlayingBox');
    searchBox = await Hive.openBox<Movie>('searchBox');
    bookmarksBox = await Hive.openBox<Movie>('bookmarksBox');
    movieDetailsBox = await Hive.openBox<Movie>('movieDetailsBox');
  }
}