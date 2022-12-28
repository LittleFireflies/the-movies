part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object?> get props => [];
}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<Movie> movies;
  final int loadedPages;
  final bool isLoadingMore;
  final bool isError;

  const MovieListLoaded({
    required this.movies,
    required this.loadedPages,
    this.isLoadingMore = false,
    this.isError = false,
  });

  @override
  List<Object?> get props => [
        movies,
        loadedPages,
        isLoadingMore,
        isError,
      ];

  MovieListLoaded copyWith({
    List<Movie>? movies,
    int? loadedPages,
    bool? isLoadingMore,
    bool? isError,
  }) {
    return MovieListLoaded(
      movies: movies ?? this.movies,
      loadedPages: loadedPages ?? this.loadedPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isError: isError ?? this.isError,
    );
  }
}

class MovieListLoadError extends MovieListState {
  final String message;

  const MovieListLoadError(this.message);

  @override
  List<Object?> get props => [message];
}
