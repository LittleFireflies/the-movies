import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_movies/services/api/models/movie.dart';
import 'package:the_movies/services/local_storage/local_storage_service.dart';
import 'package:the_movies/services/local_storage/models/favorite_movie.dart';

class HiveService implements LocalStorageService {
  static const favoriteMovies = 'favoriteMovies';

  final Box<FavoriteMovie> favoriteMoviesBox;

  HiveService(
    this.favoriteMoviesBox,
  );

  @override
  Future<void> addToFavorite({
    required Movie movie,
    required String email,
  }) async {
    final id = '$email${movie.id}';

    favoriteMoviesBox.put(
      id,
      FavoriteMovie(email: email, movie: movie),
    );
  }
}
