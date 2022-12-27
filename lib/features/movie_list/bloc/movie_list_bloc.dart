import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

        emit(MovieListLoaded(movies));
      } catch (e) {
        emit(MovieListLoadError(e.toString()));
      }
    });
  }
}
