import 'package:flutter/material.dart';

class FavoriteMovieLoadingView extends StatelessWidget {
  const FavoriteMovieLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
