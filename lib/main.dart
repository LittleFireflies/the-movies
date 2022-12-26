import 'package:flutter/material.dart';
import 'package:the_movies/features/login/view/login_page.dart';
import 'package:the_movies/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MoviesTheme.mainTheme(),
      home: const LoginPage(),
    );
  }
}
