import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movies/services/api/models/movie.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse extends Equatable {
  final List<Movie> results;

  const MovieResponse({
    required this.results,
  });

  static MovieResponse fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  @override
  List<Object?> get props => [results];
}
