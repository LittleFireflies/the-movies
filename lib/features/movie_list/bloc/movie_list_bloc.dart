import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_movies/repositories/movies_repository.dart';
import 'package:the_movies/services/api/models/movie.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MoviesRepository _moviesRepository;

  MovieListBloc(MoviesRepository apiRepository)
      : _moviesRepository = apiRepository,
        super(MovieListLoading()) {
    on<LoadMovieList>((event, emit) async {
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
    });
    on<LoadMorePages>(
      (event, emit) async {
        if (state is! MovieListLoaded) return;

        final currentState = state as MovieListLoaded;

        emit(
          currentState.copyWith(isLoadingMore: true),
        );

        try {
          final movies =
              await _moviesRepository.getPopularMovies(page: event.page);
          final loadedMovies =
              List<Movie>.from((state as MovieListLoaded).movies);
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
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
