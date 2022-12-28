import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/login/bloc/login_bloc.dart';
import 'package:the_movies/features/movie_detail/view/movie_detail_page.dart';
import 'package:the_movies/features/movie_list/bloc/movie_list_bloc.dart';
import 'package:the_movies/features/movie_list/widgets/movie_card.dart';
import 'package:the_movies/features/movie_list/widgets/movies_drawer.dart';
import 'package:the_movies/repositories/movies_repository_impl.dart';
import 'package:the_movies/services/auth/authentication_service.dart';
import 'package:the_movies/theme/typography.dart';

class MovieListPage extends StatelessWidget {
  final User? user;

  const MovieListPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository: context.read<AuthenticationService>(),
          ),
        ),
        BlocProvider(
          create: (context) => MovieListBloc(
            context.read<MoviesRepositoryImpl>(),
          )..add(LoadMovieList()),
        ),
      ],
      child: MovieListView(user: user),
    );
  }
}

class MovieListView extends StatefulWidget {
  final User? user;

  const MovieListView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final state = context.read<MovieListBloc>().state;

      if (state is MovieListLoaded) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        const scrollThreshold = 200.0;
        if (maxScroll - currentScroll <= scrollThreshold) {
          context
              .read<MovieListBloc>()
              .add(LoadMorePages(state.loadedPages + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MoviesDrawer(user: widget.user),
      appBar: AppBar(
        title: const Text('The Movies'),
      ),
      body: BlocConsumer<MovieListBloc, MovieListState>(
        listener: (context, state) {
          if (state is MovieListLoaded && state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to fetch movies data'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MovieListLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index >= state.movies.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final movie = state.movies[index];

                  return MovieCard(
                    movie: movie,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movie: movie)));
                    },
                  );
                }
              },
              itemCount: state.isLoadingMore
                  ? state.movies.length + 1
                  : state.movies.length,
            );
          } else if (state is MovieListLoadError) {
            return Text(
              state.message,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
