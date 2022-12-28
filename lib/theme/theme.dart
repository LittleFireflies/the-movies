import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_movies/theme/color_scheme.dart';

class MoviesTheme {
  static ThemeData mainTheme() {
    return applyAllStyles(
      ThemeData.from(colorScheme: MoviesColorScheme.colorScheme),
    );
  }

  static ThemeData applyAllStyles(
    ThemeData themeData,
  ) {
    return themeData.copyWith(
      textTheme: GoogleFonts.interTextTheme(themeData.textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.colorScheme.primary,
      ),
    );
  }
}
