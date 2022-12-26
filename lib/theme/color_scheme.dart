import 'package:flutter/material.dart';
import 'package:the_movies/theme/colors.dart';

class MoviesColorScheme {
  static const colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: MoviesColors.orange,
    onPrimary: MoviesColors.black,
    secondary: MoviesColors.orange,
    onSecondary: MoviesColors.black,
    error: Colors.red,
    onError: Colors.white,
    background: MoviesColors.black,
    onBackground: Colors.white,
    surface: MoviesColors.black,
    onSurface: Colors.white,
  );
}
