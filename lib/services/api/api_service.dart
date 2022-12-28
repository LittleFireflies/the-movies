import 'dart:convert';

import 'package:http/http.dart';
import 'package:the_movies/services/api/models/movie.dart';
import 'package:the_movies/services/api/models/movie_response.dart';
import 'package:the_movies/utils/exceptions.dart';

class ApiService {
  final Client client;

  ApiService(this.client);

  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=2174d146bb9c0eab47529b2e77d6b526&language=en-US&page=$page'));

    if (response.statusCode == 200) {
      final movieResponse = MovieResponse.fromJson(json.decode(response.body));

      return movieResponse.results
          .where((element) =>
              element.backdropPath != null &&
              element.posterPath != null &&
              element.title != null &&
              element.overview != null)
          .toList();
    } else {
      throw ServerException();
    }
  }
}
