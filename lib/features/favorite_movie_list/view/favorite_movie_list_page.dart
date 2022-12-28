import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/favorite_movie_list/bloc/favorite_movie_bloc.dart';
import 'package:the_movies/features/favorite_movie_list/view/favorite_movie_empty_view.dart';
import 'package:the_movies/features/favorite_movie_list/view/favorite_movie_error_view.dart';
import 'package:the_movies/features/favorite_movie_list/view/favorite_movie_loading_view.dart';
import 'package:the_movies/features/movie_detail/view/movie_detail_page.dart';
import 'package:the_movies/features/movie_list/widgets/movie_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
        builder: (context, state) {
          if (state is FavoriteMovieLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];

                return MovieCard(
                  movie: movie,
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailPage(movie: movie)))
                        .then((value) => context
                            .read<FavoriteMovieBloc>()
                            .add(LoadFavoriteMovies()));
                  },
                );
              },
              itemCount: state.movies.length,
            );
          } else if (state is FavoriteMovieLoadedEmpty) {
            return const FavoriteMovieEmptyView();
          } else if (state is FavoriteMovieLoadError) {
            return FavoriteMovieErrorView(errorMessage: state.message);
          } else {
            return const FavoriteMovieLoadingView();
          }
        },
      ),
    );
  }
}
