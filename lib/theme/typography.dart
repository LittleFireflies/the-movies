import 'package:flutter/material.dart';

class MoviesTypography {
  const MoviesTypography._();

  static TextStyle heading5 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle heading6 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle label = const TextStyle(
    fontSize: 14,
  );
}

extension MoviesTextThemeTextStyles on TextTheme {
  TextStyle get heading5 => MoviesTypography.heading5;

  TextStyle get heading6 => MoviesTypography.heading6;

  TextStyle get label => MoviesTypography.label;
}
