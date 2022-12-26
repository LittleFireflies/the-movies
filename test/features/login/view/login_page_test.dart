import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:the_movies/features/login/bloc/login_bloc.dart';
import 'package:the_movies/features/login/view/login_page.dart';
import 'package:the_movies/features/movie_list/view/movie_list_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<void> {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  group('Login Page', () {
    late NavigatorObserver mockObserver;
    late LoginBloc loginBloc;

    setUp(() {
      mockObserver = MockNavigatorObserver();
      loginBloc = MockLoginBloc();
    });

    setUpAll(() {
      registerFallbackValue(FakeRoute());
    });

    Widget buildBlocProvider({required Widget child}) {
      return BlocProvider.value(
        value: loginBloc,
        child: child,
      );
    }

    testWidgets(
      'should add LoginWithGoogle to bloc '
      'when sign in button is tapped',
      (tester) async {
        when(() => loginBloc.state).thenReturn(LoginInitial());

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const LoginView(),
              ),
            ),
          ),
        );

        expect(find.byType(ElevatedButton), findsOneWidget);

        await tester.tap(find.byType(ElevatedButton));

        verify(() => loginBloc.add(LoginWithGoogle())).called(1);
      },
    );

    testWidgets(
      'should show SnackBar '
      'and state is LoginFailed',
      (tester) async {
        when(() => loginBloc.state).thenReturn(LoginInitial());

        whenListen(
          loginBloc,
          Stream.fromIterable([
            const LoginFailed('Error!'),
          ]),
        );

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const LoginView(),
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
      },
    );

    testWidgets(
      'should open MovieListPage '
      'and state is LoginSuccess',
      (tester) async {
        when(() => loginBloc.state).thenReturn(LoginInitial());

        whenListen(
          loginBloc,
          Stream.fromIterable([
            LoginSuccess(),
          ]),
        );

        await mockNetworkImagesFor(
          () => tester.pumpWidget(
            MaterialApp(
              home: buildBlocProvider(
                child: const LoginView(),
              ),
              navigatorObservers: [mockObserver],
            ),
          ),
        );

        await tester.pumpAndSettle();

        verify(() => mockObserver.didPush(any(), any()));

        expect(find.byType(MovieListPage), findsOneWidget);
      },
    );
  });
}
