import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movies/utils/hive/hive_type_id.dart';

part 'movie.g.dart';

@HiveType(typeId: HiveTypeIds.movie)
@JsonSerializable(createToJson: false)
class Movie extends Equatable {
  @HiveField(MovieFieldIds.id)
  final int id;
  @HiveField(MovieFieldIds.title)
  final String? title;
  @HiveField(MovieFieldIds.overview)
  final String? overview;
  @HiveField(MovieFieldIds.backdropPath)
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @HiveField(MovieFieldIds.posterPath)
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @HiveField(MovieFieldIds.voteAverage)
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.voteAverage,
  });

  static Movie fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        backdropPath,
        posterPath,
        voteAverage,
      ];
}
