import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/features/movie_list/bloc/movie_list_bloc.dart';
import 'package:the_movies/repositories/movies_repository.dart';

import '../../../helpers/test_models.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  group('MovieListBloc', () {
    late MoviesRepository moviesRepository;
    late MovieListBloc movieListBloc;

    const movie = TestModels.movie;
    const movie2 = TestModels.movie2;

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
        const MovieListLoaded(movies: [movie], loadedPages: 1),
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

    group('Load More', () {
      const seedState = MovieListLoaded(
        movies: [movie],
        loadedPages: 1,
      );
      const nextPage = 2;

      blocTest<MovieListBloc, MovieListState>(
        'should emit MoviesLoaded '
        'with new movies '
        'when LoadMorePages is added '
        'and repository return movie list',
        setUp: () {
          when(() => moviesRepository.getPopularMovies(page: nextPage))
              .thenAnswer((_) async => [movie2]);
        },
        build: () => movieListBloc,
        seed: () => seedState,
        act: (bloc) => bloc.add(const LoadMorePages(nextPage)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          seedState.copyWith(isLoadingMore: true),
          seedState.copyWith(movies: [movie, movie2], loadedPages: 2),
        ],
        verify: (_) {
          verify(() => moviesRepository.getPopularMovies(page: nextPage))
              .called(1);
        },
      );

      blocTest<MovieListBloc, MovieListState>(
        'should emit MoviesLoaded '
        'with isError true '
        'when LoadMorePages is added '
        'and repository throws an exception',
        setUp: () {
          when(() => moviesRepository.getPopularMovies(page: nextPage))
              .thenThrow(exception);
        },
        build: () => movieListBloc,
        seed: () => seedState,
        act: (bloc) => bloc.add(const LoadMorePages(nextPage)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          seedState.copyWith(isLoadingMore: true),
          seedState.copyWith(movies: [movie], isError: true),
          seedState.copyWith(movies: [movie]),
        ],
        verify: (_) {
          verify(() => moviesRepository.getPopularMovies(page: nextPage))
              .called(1);
        },
      );
    });
  });
}
