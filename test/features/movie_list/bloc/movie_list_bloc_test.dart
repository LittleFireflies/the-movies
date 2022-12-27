import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/features/movie_list/bloc/movie_list_bloc.dart';
import 'package:the_movies/repositories/movies_repository.dart';
import 'package:the_movies/services/api/models/movie.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  group('MovieListBloc', () {
    late MoviesRepository moviesRepository;
    late MovieListBloc movieListBloc;

    const movie = Movie(
      id: 123,
      title: 'title',
      overview: 'overview',
      backdropPath: 'backdropPath',
      posterPath: 'posterPath',
      voteAverage: 7.6,
    );

    final exception = Exception('Error!');

    setUp(() {
      moviesRepository = MockMoviesRepository();
      movieListBloc = MovieListBloc(moviesRepository);
    });

    blocTest(
      'should emit MoviesLoaded '
      'when LoadMovieList is added '
      'and repository return movie list',
      setUp: () {
        when(() => moviesRepository.getPopularMovies())
            .thenAnswer((_) async => [movie]);
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(LoadMovieList()),
      expect: () => [
        MovieListLoading(),
        const MovieListLoaded([movie]),
      ],
      verify: (_) {
        verify(() => moviesRepository.getPopularMovies()).called(1);
      },
    );

    blocTest(
      'should emit MoviesLoadError '
      'when LoadMovieList is added '
      'and repository return movie list',
      setUp: () {
        when(() => moviesRepository.getPopularMovies()).thenThrow(exception);
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(LoadMovieList()),
      expect: () => [
        MovieListLoading(),
        MovieListLoadError(exception.toString()),
      ],
      verify: (_) {
        verify(() => moviesRepository.getPopularMovies()).called(1);
      },
    );
  });
}
