import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/features/movie_list/bloc/movie_list_bloc.dart';
import 'package:the_movies/services/api/api_repository.dart';
import 'package:the_movies/services/api/models/movie.dart';

class MockApiRepository extends Mock implements ApiRepository {}

void main() {
  group('MovieListBloc', () {
    late ApiRepository apiRepository;
    late MovieListBloc movieListBloc;

    const movie = Movie(
      id: 123,
      title: 'title',
      overview: 'overview',
      backdropPath: 'backdropPath',
      posterPath: 'posterPath',
    );

    final exception = Exception('Error!');

    setUp(() {
      apiRepository = MockApiRepository();
      movieListBloc = MovieListBloc(apiRepository);
    });

    blocTest(
      'should emit MoviesLoaded '
      'when LoadMovieList is added '
      'and repository return movie list',
      setUp: () {
        when(() => apiRepository.getPopularMovies())
            .thenAnswer((_) async => [movie]);
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(LoadMovieList()),
      expect: () => [
        MovieListLoading(),
        const MovieListLoaded([movie]),
      ],
      verify: (_) {
        verify(() => apiRepository.getPopularMovies()).called(1);
      },
    );

    blocTest(
      'should emit MoviesLoadError '
      'when LoadMovieList is added '
      'and repository return movie list',
      setUp: () {
        when(() => apiRepository.getPopularMovies()).thenThrow(exception);
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(LoadMovieList()),
      expect: () => [
        MovieListLoading(),
        MovieListLoadError(exception.toString()),
      ],
      verify: (_) {
        verify(() => apiRepository.getPopularMovies()).called(1);
      },
    );
  });
}
