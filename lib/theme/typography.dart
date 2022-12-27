import 'package:flutter/material.dart';

class MoviesTypography {
  const MoviesTypography._();

  static TextStyle title = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyText = const TextStyle(
    fontSize: 14,
  );
}

extension MoviesTextThemeTextStyles on TextTheme {
  TextStyle get title => MoviesTypography.title;

  TextStyle get bodyText => MoviesTypography.bodyText;
}
