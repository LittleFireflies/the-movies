import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/repositories/movies_repository.dart';
import 'package:the_movies/services/api/models/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MoviesRepository _moviesRepository;

  MovieDetailBloc(MoviesRepository moviesRepository)
      : _moviesRepository = moviesRepository,
        super(MovieDetailLoading()) {
    on<GetFavoriteStatus>((event, emit) => _onGetFavoriteStatus(emit, event));
    on<AddToFavorite>((event, emit) => _onAddToFavorite(emit, event));
    on<RemoveFromFavorite>((event, emit) => _onRemoveFromFavorite(emit, event));
  }

  Future<void> _onGetFavoriteStatus(
    Emitter<MovieDetailState> emit,
    GetFavoriteStatus event,
  ) async {
    emit(MovieDetailLoading());

    final isFavorite = await _moviesRepository.isFavorite(event.movie);

    emit(MovieDetailLoaded(isFavorite: isFavorite));
  }

  Future<void> _onAddToFavorite(
    Emitter<MovieDetailState> emit,
    AddToFavorite event,
  ) async {
    emit(MovieDetailLoading());

    try {
      await _moviesRepository.addToFavorite(event.movie);

      emit(AddToFavoriteSuccess());
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _onRemoveFromFavorite(
    Emitter<MovieDetailState> emit,
    RemoveFromFavorite event,
  ) async {
    emit(MovieDetailLoading());

    try {
      await _moviesRepository.removeFromFavorite(event.movie);

      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
