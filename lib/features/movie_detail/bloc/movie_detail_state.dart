part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final bool isFavorite;

  const MovieDetailLoaded({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}

class AddToFavoriteSuccess extends MovieDetailState {}
