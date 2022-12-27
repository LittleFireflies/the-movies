part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object?> get props => [];
}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;

  const MovieListLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieListLoadError extends MovieListState {
  final String message;

  const MovieListLoadError(this.message);

  @override
  List<Object?> get props => [message];
}
