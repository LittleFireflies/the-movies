import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/repositories/movies_repository_impl.dart';
import 'package:the_movies/services/api/api_service.dart';
import 'package:the_movies/services/auth/authentication_service.dart';
import 'package:the_movies/services/local_storage/local_storage_service.dart';
import 'package:the_movies/utils/exceptions.dart';

import '../helpers/test_models.dart';

class MockApiService extends Mock implements ApiService {}

class MockStorageService extends Mock implements LocalStorageService {}

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockUser extends Mock implements User {}

void main() {
  group('MoviesRepositoryImpl', () {
    late ApiService apiService;
    late LocalStorageService storageService;
    late AuthenticationService authenticationService;
    late MoviesRepositoryImpl repository;

    late User user;

    final movies = [TestModels.movie];

    setUp(() {
      apiService = MockApiService();
      storageService = MockStorageService();
      authenticationService = MockAuthenticationService();
      repository = MoviesRepositoryImpl(
        apiService: apiService,
        storageService: storageService,
        authenticationService: authenticationService,
      );

      user = MockUser();
      when(() => authenticationService.getCurrentUser())
          .thenAnswer((_) async => user);
    });

    test(
      'should call apiService.getPopularMovies '
      'and return list of movies '
      'when getPopularMovies is called',
      () async {
        when(() => apiService.getPopularMovies())
            .thenAnswer((_) async => movies);

        final result = await repository.getPopularMovies();

        expect(result, movies);
        verify(() => apiService.getPopularMovies()).called(1);
      },
    );

    test(
      'should call storageService.addToFavorite '
      'when addToFavorite is called',
      () async {
        when(() => storageService.addToFavorite(
              movie: movies[0],
              email: any(named: 'email'),
            )).thenAnswer((_) => Future.value());

        await repository.addToFavorite(movies[0]);

        verify(() => storageService.addToFavorite(
            movie: movies[0], email: any(named: 'email'))).called(1);
      },
    );

    test(
      'should call storageService.getFavoriteMovieByMovie '
      'and return true '
      'when isFavorite is called '
      'and favorite movie is exist',
      () async {
        when(() => storageService.getFavoriteMovieByMovie(
              movie: movies[0],
              email: any(named: 'email'),
            )).thenAnswer((_) async => movies[0]);

        final result = await repository.isFavorite(movies[0]);

        expect(result, true);
        verify(() => storageService.getFavoriteMovieByMovie(
            movie: movies[0], email: any(named: 'email'))).called(1);
      },
    );

    test(
      'should call storageService.getFavoriteMovieByMovie '
      'and return false '
      'when isFavorite is called '
      'and favorite movie is not exist',
      () async {
        when(() => storageService.getFavoriteMovieByMovie(
              movie: movies[0],
              email: any(named: 'email'),
            )).thenAnswer((_) async => null);

        final result = await repository.isFavorite(movies[0]);

        expect(result, false);
        verify(() => storageService.getFavoriteMovieByMovie(
            movie: movies[0], email: any(named: 'email'))).called(1);
      },
    );

    test(
      'should call storageService.removeFromFavorite '
      'when removeFromFavorite is called',
      () async {
        when(() => storageService.removeFromFavorite(
              movie: movies[0],
              email: any(named: 'email'),
            )).thenAnswer((_) => Future.value());

        await repository.removeFromFavorite(movies[0]);

        verify(() => storageService.removeFromFavorite(
            movie: movies[0], email: any(named: 'email'))).called(1);
      },
    );

    test(
      'should call storageService.getFavoriteMovies '
      'and return favorite movies '
      'when getFavoriteMovies is called',
      () async {
        when(() => storageService.getFavoriteMovies(
              email: any(named: 'email'),
            )).thenAnswer((_) async => movies);

        final result = await repository.getFavoriteMovies();

        expect(result, movies);
        verify(() =>
                storageService.getFavoriteMovies(email: any(named: 'email')))
            .called(1);
      },
    );

    group('when user is unauthenticated', () {
      setUp(() {
        when(() => authenticationService.getCurrentUser())
            .thenAnswer((_) async => null);
      });

      test('should throw UnauthenticatiedException', () {
        expect(
          () => repository.addToFavorite(movies[0]),
          throwsA(isA<UnauthenticatedException>()),
        );
        expect(
          () => repository.isFavorite(movies[0]),
          throwsA(isA<UnauthenticatedException>()),
        );
        expect(
          () => repository.removeFromFavorite(movies[0]),
          throwsA(isA<UnauthenticatedException>()),
        );
        expect(
          () => repository.getFavoriteMovies(),
          throwsA(isA<UnauthenticatedException>()),
        );
      });
    });
  });
}
