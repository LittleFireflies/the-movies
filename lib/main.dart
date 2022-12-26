import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_movies/features/login/view/login_page.dart';
import 'package:the_movies/firebase_options.dart';
import 'package:the_movies/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
