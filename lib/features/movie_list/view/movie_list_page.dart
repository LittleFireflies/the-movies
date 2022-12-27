import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/login/bloc/login_bloc.dart';
import 'package:the_movies/features/movie_list/widgets/movies_drawer.dart';
import 'package:the_movies/services/auth/authentication_service.dart';

class MovieListPage extends StatelessWidget {
  final User? user;

  const MovieListPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: AuthenticationService(),
      ),
      child: MovieListView(user: user),
    );
  }
}

class MovieListView extends StatelessWidget {
  final User? user;

  const MovieListView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MoviesDrawer(user: user),
      appBar: AppBar(),
    );
  }
}
