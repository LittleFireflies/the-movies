import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:the_movies/features/movie_detail/models/movie_detail_keys.dart';
import 'package:the_movies/repositories/movies_repository_impl.dart';
import 'package:the_movies/services/api/models/movie.dart';
import 'package:the_movies/theme/typography.dart';
import 'package:the_movies/utils/constants.dart';
import 'package:the_movies/utils/shared_widgets/movies_image.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc(
        context.read<MoviesRepositoryImpl>(),
      ),
      child: MovieDetailView(movie: movie),
    );
  }
}

class MovieDetailView extends StatelessWidget {
  static const _posterHeight = 120.0;

  const MovieDetailView({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieDetailBloc, MovieDetailState>(
          listenWhen: (p, c) => c is AddToFavoriteSuccess,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Movie added to favorites'),
              ),
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          actions: [
            IconButton(
              key: MovieDetailKeys.favoriteButton,
              onPressed: () {
                context.read<MovieDetailBloc>().add(AddToFavorite(movie));
              },
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  MoviesImage(imageUrl: '$baseImageUrl${movie.backdropPath}'),
                  Positioned(
                    bottom: -(_posterHeight / 2),
                    left: 16,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: MoviesImage(
                        imageUrl: '$baseImageUrl${movie.posterPath}',
                        height: _posterHeight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 8),
                          Text('${movie.voteAverage}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(
                  top: _posterHeight / 2,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview',
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      movie.overview,
                      style: Theme.of(context).textTheme.bodyText.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
