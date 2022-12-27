import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movies/theme/color_scheme.dart';

class MoviesTheme {
  static ThemeData mainTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: MoviesColorScheme.colorScheme,
      textTheme: GoogleFonts.interTextTheme(),
      scaffoldBackgroundColor: MoviesColorScheme.colorScheme.background,
    );
  }
}
