import 'package:flutter/material.dart';
import 'package:the_movies/theme/typography.dart';

class FavoriteMovieEmptyView extends StatelessWidget {
  const FavoriteMovieEmptyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.movie_outlined,
          size: 80,
        ),
        const SizedBox(height: 16),
        Text(
          "You haven't add favorite movies yet",
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
