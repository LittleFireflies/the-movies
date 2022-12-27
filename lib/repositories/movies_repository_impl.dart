import 'package:the_movies/repositories/movies_repository.dart';
import 'package:the_movies/services/api/api_service.dart';
import 'package:the_movies/services/api/models/movie.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final ApiService _apiService;

  const MoviesRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Movie>> getPopularMovies() async {
    return await _apiService.getPopularMovies();
  }
}
