part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object?> get props => [];
}

class FavoriteMovieLoading extends FavoriteMovieState {}

class FavoriteMovieLoaded extends FavoriteMovieState {
  final List<Movie> movies;

  const FavoriteMovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class FavoriteMovieLoadedEmpty extends FavoriteMovieState {}

class FavoriteMovieLoadError extends FavoriteMovieState {
  final String message;

  const FavoriteMovieLoadError(this.message);

  @override
  List<Object?> get props => [message];
}
