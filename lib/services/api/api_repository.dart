import 'package:the_movies/services/api/models/movie.dart';

abstract class ApiRepository {
  Future<List<Movie>> getPopularMovies();
}
