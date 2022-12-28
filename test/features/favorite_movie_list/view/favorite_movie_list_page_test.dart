import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:the_movies/features/favorite_movie_list/bloc/favorite_movie_bloc.dart';
import 'package:the_movies/features/favorite_movie_list/view/favorite_movie_empty_view.dart';
import 'package:the_movies/features/favorite_movie_list/view/favorite_movie_error_view.dart';
import 'package:the_movies/features/favorite_movie_list/view/favorite_movie_list_page.dart';
import 'package:the_movies/features/favorite_movie_list/view/favorite_movie_loading_view.dart';

import '../../../helpers/test_models.dart';

class MockFavoriteMovieBloc
    extends MockBloc<FavoriteMovieEvent, FavoriteMovieState>
    implements FavoriteMovieBloc {}

void main() {
  group('FavoriteMovieListPage', () {
    late FavoriteMovieBloc favoriteMovieBloc;

    const movies = [TestModels.movie];

    setUp(() {
      favoriteMovieBloc = MockFavoriteMovieBloc();
    });

    Widget buildBlocProvider({required Widget child}) {
      return BlocProvider.value(
        value: favoriteMovieBloc,
        child: child,
      );
    }

    testWidgets(
      'should display ListView '
      'when state is FavoriteMovieLoaded',
      (tester) async {
        when(() => favoriteMovieBloc.state)
            .thenReturn(const FavoriteMovieLoaded(movies));

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const FavoriteMovieListView(),
              ),
            ),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
      },
    );

    testWidgets(
      'should display FavoriteMovieEmptyView '
      'when state is FavoriteMovieLoadedEmpty',
      (tester) async {
        when(() => favoriteMovieBloc.state)
            .thenReturn(FavoriteMovieLoadedEmpty());

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const FavoriteMovieListView(),
              ),
            ),
          ),
        );

        expect(find.byType(FavoriteMovieEmptyView), findsOneWidget);
      },
    );

    testWidgets(
      'should display FavoriteMovieErrorView '
      'when state is FavoriteMovieLoadError',
      (tester) async {
        when(() => favoriteMovieBloc.state)
            .thenReturn(const FavoriteMovieLoadError('Error'));

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const FavoriteMovieListView(),
              ),
            ),
          ),
        );

        expect(find.byType(FavoriteMovieErrorView), findsOneWidget);
      },
    );

    testWidgets(
      'should display FavoriteMovieLoadingView '
      'when state is FavoriteMovieLoading',
      (tester) async {
        when(() => favoriteMovieBloc.state).thenReturn(FavoriteMovieLoading());

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const FavoriteMovieListView(),
              ),
            ),
          ),
        );

        expect(find.byType(FavoriteMovieLoadingView), findsOneWidget);
      },
    );
  });
}
