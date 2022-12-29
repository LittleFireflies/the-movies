import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/repositories/movies_repository.dart';
import 'package:the_movies/services/api/models/movie.dart';
import 'package:the_movies/utils/extensions/bloc.ext.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MoviesRepository _moviesRepository;

  MovieListBloc(MoviesRepository apiRepository)
      : _moviesRepository = apiRepository,
        super(MovieListLoading()) {
    on<LoadMovieList>((event, emit) => _onLoadMovieList(emit));
    on<LoadMorePages>(
      (event, emit) => _onLoadMorePages(emit, event),
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onLoadMovieList(Emitter<MovieListState> emit) async {
    emit(MovieListLoading());

    try {
      final movies = await _moviesRepository.getPopularMovies();

      emit(MovieListLoaded(
        movies: movies,
        loadedPages: 1,
      ));
    } catch (e) {
      emit(MovieListLoadError(e.toString()));
    }
  }

  Future<void> _onLoadMorePages(
    Emitter<MovieListState> emit,
    LoadMorePages event,
  ) async {
    if (state is! MovieListLoaded) return;

    final currentState = state as MovieListLoaded;

    emit(
      currentState.copyWith(isLoadingMore: true),
    );

    try {
      final movies = await _moviesRepository.getPopularMovies(page: event.page);
      final loadedMovies = List<Movie>.from((state as MovieListLoaded).movies);
      loadedMovies.addAll(movies);

      emit(
        currentState.copyWith(
          movies: loadedMovies,
          loadedPages: event.page,
        ),
      );
    } catch (e) {
      // Trigger error state once
      emit(currentState.copyWith(isError: true));
      emit(currentState.copyWith());
    }
  }
}
