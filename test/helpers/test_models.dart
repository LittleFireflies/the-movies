import 'package:the_movies/services/api/models/movie.dart';

class TestModels {
  static const movie = Movie(
    id: 123,
    title: 'title',
    overview: 'overview',
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    voteAverage: 7.6,
  );

  static const movie2 = Movie(
    id: 1234,
    title: 'title2',
    overview: 'overview',
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    voteAverage: 7.9,
  );
}
