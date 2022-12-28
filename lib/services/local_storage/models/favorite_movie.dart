import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:the_movies/services/api/models/movie.dart';
import 'package:the_movies/utils/hive/hive_type_id.dart';

part 'favorite_movie.g.dart';

@HiveType(typeId: HiveTypeIds.favoriteMovie)
class FavoriteMovie extends Equatable {
  @HiveField(FavoriteMovieFieldIds.email)
  final String email;
  @HiveField(FavoriteMovieFieldIds.movie)
  final Movie movie;

  const FavoriteMovie({
    required this.email,
    required this.movie,
  });

  @override
  List<Object?> get props => [email, movie];
}
