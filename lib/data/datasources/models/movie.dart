import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Movie {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @HiveField(3)
  @JsonKey(name: 'overview')
  final String overview;

  @HiveField(4)
  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @HiveField(5)
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.overview,
    this.releaseDate,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}