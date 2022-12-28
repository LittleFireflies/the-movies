import 'package:the_movies/services/api/models/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<void> addToFavorite(Movie movie);
  Future<bool> isFavorite(Movie movie);
  Future<void> removeFromFavorite(Movie movie);
  Future<List<Movie>> getFavoriteMovies();
}
