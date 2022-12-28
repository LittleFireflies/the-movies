import 'package:the_movies/repositories/movies_repository.dart';
import 'package:the_movies/services/api/api_service.dart';
import 'package:the_movies/services/api/models/movie.dart';
import 'package:the_movies/services/auth/authentication_service.dart';
import 'package:the_movies/services/local_storage/local_storage_service.dart';
import 'package:the_movies/utils/exceptions.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final ApiService _apiService;
  final LocalStorageService _storageService;
  final AuthenticationService _authenticationService;

  const MoviesRepositoryImpl({
    required ApiService apiService,
    required LocalStorageService storageService,
    required AuthenticationService authenticationService,
  })  : _apiService = apiService,
        _storageService = storageService,
        _authenticationService = authenticationService;

  @override
  Future<List<Movie>> getPopularMovies() async {
    return await _apiService.getPopularMovies();
  }

  @override
  Future<void> addToFavorite(Movie movie) async {
    final user = await _authenticationService.getCurrentUser();

    if (user != null) {
      await _storageService.addToFavorite(
        movie: movie,
        email: user.email ?? '',
      );
    } else {
      throw const UnauthenticatedException();
    }
  }
}
