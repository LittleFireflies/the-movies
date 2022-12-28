import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/features/favorite_movie_list/bloc/favorite_movie_bloc.dart';
import 'package:the_movies/repositories/movies_repository.dart';

import '../../../helpers/test_models.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  group('FavoriteMovieBloc', () {
    late MoviesRepository moviesRepository;
    late FavoriteMovieBloc favoriteMovieBloc;

    const movies = [TestModels.movie];

    final exception = Exception('Error!');

    setUp(() {
      moviesRepository = MockMoviesRepository();
      favoriteMovieBloc = FavoriteMovieBloc(moviesRepository);
    });

    blocTest(
      'should emit FavoriteMovieLoaded '
      'when LoadFavoriteMovies is added '
      'and repository returns list of movies',
      setUp: () {
        when(() => moviesRepository.getFavoriteMovies())
            .thenAnswer((_) async => movies);
      },
      build: () => favoriteMovieBloc,
      act: (bloc) => bloc.add(LoadFavoriteMovies()),
      expect: () => [
        FavoriteMovieLoading(),
        const FavoriteMovieLoaded(movies),
      ],
      verify: (_) {
        verify(() => moviesRepository.getFavoriteMovies()).called(1);
      },
    );

    blocTest(
      'should emit FavoriteMovieLoadedEmpty '
      'when LoadFavoriteMovies is added '
      'and repository returns empty list',
      setUp: () {
        when(() => moviesRepository.getFavoriteMovies())
            .thenAnswer((_) async => []);
      },
      build: () => favoriteMovieBloc,
      act: (bloc) => bloc.add(LoadFavoriteMovies()),
      expect: () => [
        FavoriteMovieLoading(),
        FavoriteMovieLoadedEmpty(),
      ],
      verify: (_) {
        verify(() => moviesRepository.getFavoriteMovies()).called(1);
      },
    );

    blocTest(
      'should emit FavoriteMovieLoadError '
      'when LoadFavoriteMovies is added '
      'and repository throws exception',
      setUp: () {
        when(() => moviesRepository.getFavoriteMovies()).thenThrow(exception);
      },
      build: () => favoriteMovieBloc,
      act: (bloc) => bloc.add(LoadFavoriteMovies()),
      expect: () => [
        FavoriteMovieLoading(),
        FavoriteMovieLoadError(exception.toString()),
      ],
      verify: (_) {
        verify(() => moviesRepository.getFavoriteMovies()).called(1);
      },
    );
  });
}
