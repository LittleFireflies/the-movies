import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:the_movies/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:the_movies/features/movie_detail/models/movie_detail_keys.dart';
import 'package:the_movies/features/movie_detail/view/movie_detail_page.dart';

import '../../../helpers/test_models.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  group('MovieDetailPage', () {
    late MovieDetailBloc movieDetailBloc;

    const movie = TestModels.movie;

    setUp(() {
      movieDetailBloc = MockMovieDetailBloc();
    });

    Widget buildBlocProvider({required Widget child}) {
      return BlocProvider.value(
        value: movieDetailBloc,
        child: child,
      );
    }

    testWidgets(
      'should add AddToFavorite to bloc '
      'when favoriteButton is tapped '
      'and isFavorite is false',
      (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(const MovieDetailLoaded(isFavorite: false));

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const MovieDetailView(
                  movie: movie,
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byKey(MovieDetailKeys.favoriteButton));

        verify(() => movieDetailBloc.add(const AddToFavorite(movie))).called(1);
      },
    );

    testWidgets(
      'should do nothing '
      'when favoriteButton is tapped '
      'and isFavorite is true',
      (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(const MovieDetailLoaded(isFavorite: true));

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const MovieDetailView(
                  movie: movie,
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byKey(MovieDetailKeys.favoriteButton));

        verifyNever(() => movieDetailBloc.add(const AddToFavorite(movie)));
      },
    );

    testWidgets(
      'should display SnackBar '
      'and add GetFavoriteStatus to bloc '
      'when state is AddToFavoriteSuccess',
      (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(const MovieDetailLoaded(isFavorite: false));

        whenListen(
          movieDetailBloc,
          Stream.fromIterable([
            AddToFavoriteSuccess(),
          ]),
        );

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const MovieDetailView(
                  movie: movie,
                ),
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        verify(() => movieDetailBloc.add(const GetFavoriteStatus(movie)))
            .called(1);
      },
    );
  });
}
