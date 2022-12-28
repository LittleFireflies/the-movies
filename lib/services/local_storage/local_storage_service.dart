import 'package:the_movies/services/api/models/movie.dart';

abstract class LocalStorageService {
  Future<void> addToFavorite({
    required Movie movie,
    required String email,
  });

  Future<Movie?> getFavoriteMovieByMovie({
    required Movie movie,
    required String email,
  });

  Future<void> removeFromFavorite({
    required Movie movie,
    required String email,
  });

  Future<List<Movie>> getFavoriteMovies({required String email});
}
