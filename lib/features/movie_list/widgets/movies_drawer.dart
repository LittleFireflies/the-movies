import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/features/login/bloc/login_bloc.dart';
import 'package:the_movies/features/login/view/login_page.dart';

class MoviesDrawer extends StatelessWidget {
  final User? user;
  const MoviesDrawer({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user?.photoURL ?? ''),
                    radius: 36,
                  ),
                  const SizedBox(height: 8),
                  Text(user?.displayName ?? ''),
                  const SizedBox(height: 4),
                  Text(user?.email ?? ''),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  context.read<LoginBloc>().add(Logout());
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
