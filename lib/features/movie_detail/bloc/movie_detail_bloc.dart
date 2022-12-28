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
    on<AddToFavorite>((event, emit) async {
      emit(MovieDetailLoading());

      await _moviesRepository.addToFavorite(event.movie);

      emit(AddToFavoriteSuccess());
    });
  }
}
