import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/login/bloc/login_bloc.dart';
import 'package:the_movies/features/movie_list/view/movie_list_page.dart';
import 'package:the_movies/services/auth/authentication_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: AuthenticationService(),
      )..add(GetSignedInUser()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }

        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MovieListPage()));
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1595769816263-9b910be24d5f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2079&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'The Movies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Icon(
                    Icons.movie,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Millions of movies to discover'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginWithGoogle());
                        },
                        child: const Text(
                          'Login with Google',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
