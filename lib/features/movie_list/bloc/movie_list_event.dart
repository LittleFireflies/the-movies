part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieList extends MovieListEvent {}

class LoadMorePages extends MovieListEvent {
  final int page;

  const LoadMorePages(this.page);

  @override
  List<Object?> get props => [page];
}
