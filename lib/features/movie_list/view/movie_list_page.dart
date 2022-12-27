import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/login/bloc/login_bloc.dart';
import 'package:the_movies/features/login/view/login_page.dart';
import 'package:the_movies/services/auth/authentication_service.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: AuthenticationService(),
      ),
      child: const MovieListView(),
    );
  }
}

class MovieListView extends StatelessWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: () {
                context.read<LoginBloc>().add(Logout());
              },
              child: const Text(
                'Log Out',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        appBar: AppBar(),
      ),
    );
  }
}
