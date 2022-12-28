part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieEvent extends Equatable {
  const FavoriteMovieEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoriteMovies extends FavoriteMovieEvent {}
