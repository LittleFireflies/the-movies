import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/repositories/movies_repository.dart';
import 'package:the_movies/services/api/models/movie.dart';

part 'favorite_movie_event.dart';
part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final MoviesRepository _moviesRepository;

  FavoriteMovieBloc(MoviesRepository moviesRepository)
      : _moviesRepository = moviesRepository,
        super(FavoriteMovieLoading()) {
    on<LoadFavoriteMovies>((event, emit) async {
      emit(FavoriteMovieLoading());

      try {
        final favoriteMovies = await _moviesRepository.getFavoriteMovies();

        if (favoriteMovies.isNotEmpty) {
          emit(FavoriteMovieLoaded(favoriteMovies));
        } else {
          emit(FavoriteMovieLoadedEmpty());
        }
      } catch (e) {
        emit(FavoriteMovieLoadError(e.toString()));
      }
    });
  }
}
