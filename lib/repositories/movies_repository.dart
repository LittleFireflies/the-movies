import 'package:the_movies/services/api/models/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getPopularMovies();
  Future<void> addToFavorite(Movie movie);
  Future<bool> isFavorite(Movie movie);
}
