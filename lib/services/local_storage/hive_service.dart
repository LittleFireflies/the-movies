import 'package:collection/collection.dart';
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

  @override
  Future<Movie?> getFavoriteMovieByMovie({
    required Movie movie,
    required String email,
  }) {
    final id = '$email${movie.id}';
    final favoriteMovie = favoriteMoviesBox.get(id);

    return Future.value(favoriteMovie?.movie);
  }

  @override
  Future<void> removeFromFavorite({
    required Movie movie,
    required String email,
  }) async {
    final id = '$email${movie.id}';

    favoriteMoviesBox.delete(id);
  }

  @override
  Future<List<Movie>> getFavoriteMovies({required String email}) {
    final favoriteMovies = favoriteMoviesBox.keys.map((key) {
      return favoriteMoviesBox.get(key);
    }).toList();

    final movies = favoriteMovies
        .whereNotNull()
        .where((favoriteMovie) => favoriteMovie.email == email)
        .map((favoriteMovie) => favoriteMovie.movie)
        .toList();

    return Future.value(movies);
  }
}
