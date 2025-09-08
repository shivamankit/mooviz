import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final int page;

  @JsonKey(name: 'results')
  final List<Movie> results;

  @JsonKey(name: 'total_results')
  final int totalResults;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  MovieResponse({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}