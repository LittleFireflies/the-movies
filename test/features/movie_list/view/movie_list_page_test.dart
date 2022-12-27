import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:the_movies/features/movie_list/bloc/movie_list_bloc.dart';
import 'package:the_movies/features/movie_list/view/movie_list_page.dart';
import 'package:the_movies/services/api/models/movie.dart';

class MockMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

class MockUser extends Mock implements User {}

void main() {
  group('MovieListPage', () {
    late MovieListBloc movieListBloc;
    late User mockUser;

    const movie = Movie(
      id: 123,
      title: 'title',
      overview: 'overview',
      backdropPath: 'backdropPath',
      posterPath: 'posterPath',
      voteAverage: 7.6,
    );

    setUp(() {
      movieListBloc = MockMovieListBloc();
      mockUser = MockUser();
    });

    Widget buildBlocProvider({required Widget child}) {
      return BlocProvider.value(
        value: movieListBloc,
        child: child,
      );
    }

    testWidgets(
      'should display ListView '
      'when state is MovieListLoaded',
      (tester) async {
        when(() => movieListBloc.state)
            .thenReturn(const MovieListLoaded([movie]));

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: MovieListView(
                  user: mockUser,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
      },
    );

    testWidgets(
      'should display CircularProgressIndicator '
      'when state is MovieListLoading',
      (tester) async {
        when(() => movieListBloc.state).thenReturn(MovieListLoading());

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: MovieListView(
                  user: mockUser,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );
  });
}
