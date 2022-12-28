import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:the_movies/features/login/view/login_page.dart';
import 'package:the_movies/firebase_options.dart';
import 'package:the_movies/repositories/movies_repository_impl.dart';
import 'package:the_movies/services/api/api_service.dart';
import 'package:the_movies/services/api/models/movie.dart';
import 'package:the_movies/services/auth/authentication_service.dart';
import 'package:the_movies/services/local_storage/hive_service.dart';
import 'package:the_movies/services/local_storage/models/favorite_movie.dart';
import 'package:the_movies/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HiveService hiveService = await _setUpHive();

  runApp(
    MyApp(
      hiveService: hiveService,
    ),
  );
}

Future<HiveService> _setUpHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteMovieAdapter());
  Hive.registerAdapter(MovieAdapter());

  final favoriteMoviesBox =
      await Hive.openBox<FavoriteMovie>(HiveService.favoriteMovies);
  final hiveService = HiveService(favoriteMoviesBox);

  return hiveService;
}

class MyApp extends StatelessWidget {
  final HiveService _hiveService;

  const MyApp({
    super.key,
    required HiveService hiveService,
  }) : _hiveService = hiveService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _hiveService),
        RepositoryProvider(
          create: (context) => ApiService(
            Client(),
          ),
        ),
        RepositoryProvider(create: (context) => AuthenticationService()),
        RepositoryProvider(
          create: (context) => MoviesRepositoryImpl(
            apiService: context.read<ApiService>(),
            storageService: context.read<HiveService>(),
            authenticationService: context.read<AuthenticationService>(),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: MoviesTheme.mainTheme(),
        home: const LoginPage(),
      ),
    );
  }
}
