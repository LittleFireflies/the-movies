import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:the_movies/repositories/movies_repository.dart';

import '../../../helpers/test_models.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  group('MovieDetailBloc', () {
    late MoviesRepository moviesRepository;
    late MovieDetailBloc movieDetailBloc;

    const movie = TestModels.movie;

    setUp(() {
      moviesRepository = MockMoviesRepository();
      movieDetailBloc = MovieDetailBloc(moviesRepository);
    });

    blocTest(
      'should emit AddToFavoriteSuccess '
      'when AddToFavorite is added '
      'and favorite movie added successfully',
      setUp: () {
        when(() => moviesRepository.addToFavorite(movie))
            .thenAnswer((_) async => Future.value());
      },
      build: () => movieDetailBloc,
      act: (bloc) => bloc.add(const AddToFavorite(movie)),
      expect: () => [
        MovieDetailLoading(),
        AddToFavoriteSuccess(),
      ],
      verify: (_) {
        verify(() => moviesRepository.addToFavorite(movie)).called(1);
      },
    );

    blocTest(
      'should emit MovieDetailLoaded '
      'and isFavorite is true '
      'when GetFavoriteStatus is added '
      'and repository returns true',
      setUp: () {
        when(() => moviesRepository.isFavorite(movie))
            .thenAnswer((_) async => true);
      },
      build: () => movieDetailBloc,
      act: (bloc) => bloc.add(const GetFavoriteStatus(movie)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailLoaded(isFavorite: true),
      ],
      verify: (_) {
        verify(() => moviesRepository.isFavorite(movie)).called(1);
      },
    );
  });
}
