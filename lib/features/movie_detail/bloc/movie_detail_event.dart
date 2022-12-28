part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetFavoriteStatus extends MovieDetailEvent {
  final Movie movie;

  const GetFavoriteStatus(this.movie);

  @override
  List<Object?> get props => [movie];
}

class AddToFavorite extends MovieDetailEvent {
  final Movie movie;

  const AddToFavorite(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveFromFavorite extends MovieDetailEvent {
  final Movie movie;

  const RemoveFromFavorite(this.movie);

  @override
  List<Object?> get props => [movie];
}
