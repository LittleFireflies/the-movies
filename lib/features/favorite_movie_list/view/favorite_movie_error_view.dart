import 'package:flutter/material.dart';
import 'package:the_movies/theme/typography.dart';

class FavoriteMovieErrorView extends StatelessWidget {
  final String errorMessage;

  const FavoriteMovieErrorView({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
        textAlign: TextAlign.center,
      ),
    );
  }
}
