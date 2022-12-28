import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/favorite_movie_list/bloc/favorite_movie_bloc.dart';
import 'package:the_movies/repositories/movies_repository_impl.dart';

class FavoriteMovieListPage extends StatelessWidget {
  const FavoriteMovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteMovieBloc(context.read<MoviesRepositoryImpl>())
            ..add(LoadFavoriteMovies()),
      child: const FavoriteMovieListView(),
    );
  }
}

class FavoriteMovieListView extends StatelessWidget {
  const FavoriteMovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Favorite Movies'),
    );
  }
}
