import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  @JsonKey(name: 'poster_path')
  final String posterPath;

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
  });

  static Movie fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        backdropPath,
        posterPath,
      ];
}
