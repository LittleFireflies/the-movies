import 'package:the_movies/services/api/models/movie.dart';

abstract class LocalStorageService {
  Future<void> addToFavorite({
    required Movie movie,
    required String email,
  });
}
