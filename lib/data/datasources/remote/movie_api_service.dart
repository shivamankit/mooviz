import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/movie_detail.dart';
import '../models/movie_response.dart';
part 'movie_api_service.g.dart';

@RestApi()
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;

  @GET('/trending/movie/day')
  Future<MovieResponse> getTrending();

  @GET('/movie/now_playing')
  Future<MovieResponse> getNowPlaying();

  @GET('/search/movie')
  Future<MovieResponse> searchMovies(@Query('query') String query);

  @GET('/movie/{id}')
  Future<MovieDetail> getMovieDetails(@Path('id') int id);
}