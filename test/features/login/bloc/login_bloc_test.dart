import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:the_movies/features/login/bloc/login_bloc.dart';
import 'package:the_movies/services/auth/authentication_repository.dart';

class MockRepository extends Mock implements AuthenticationRepository {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  group('LoginBloc', () {
    late AuthenticationRepository authenticationRepository;
    late LoginBloc loginBloc;

    final exception = Exception('Error!');

    setUp(() {
      authenticationRepository = MockRepository();
      loginBloc = LoginBloc(authenticationRepository: authenticationRepository);
    });

    group('LoginWithGoogle', () {
      blocTest(
        'should emit LoginLoading and LoginSuccess '
        'when LoginWithGoogle event is added '
        'and auth is successful',
        setUp: () {
          when(() => authenticationRepository.signInWithGoogle())
              .thenAnswer((_) async => MockUserCredential());
        },
        build: () => loginBloc,
        act: (bloc) => bloc.add(LoginWithGoogle()),
        expect: () => [
          LoginLoading(),
          LoginSuccess(),
        ],
        verify: (_) {
          verify(() => authenticationRepository.signInWithGoogle()).called(1);
        },
      );

      blocTest(
        'should emit LoginLoading and LoginFailed '
        'when LoginWithGoogle event is added '
        'and auth is failed',
        setUp: () {
          when(() => authenticationRepository.signInWithGoogle())
              .thenThrow(exception);
        },
        build: () => loginBloc,
        act: (bloc) => bloc.add(LoginWithGoogle()),
        expect: () => [
          LoginLoading(),
          LoginFailed(exception.toString()),
        ],
        verify: (_) {
          verify(() => authenticationRepository.signInWithGoogle()).called(1);
        },
      );
    });

    group('GetSignedInUser', () {
      blocTest(
        'should emit LoginSuccess '
        'when GetSignedInUser event is added '
        'and user is exist',
        setUp: () {
          when(() => authenticationRepository.getCurrentUser())
              .thenAnswer((_) async => MockUser());
        },
        build: () => loginBloc,
        act: (bloc) => bloc.add(GetSignedInUser()),
        expect: () => [
          LoginLoading(),
          LoginSuccess(),
        ],
        verify: (_) {
          verify(() => authenticationRepository.getCurrentUser()).called(1);
        },
      );

      blocTest(
        'should emit LoginInitial '
        'when GetSignedInUser event is added '
        'and user is not exist exist',
        setUp: () {
          when(() => authenticationRepository.getCurrentUser())
              .thenAnswer((_) async => null);
        },
        build: () => loginBloc,
        act: (bloc) => bloc.add(GetSignedInUser()),
        expect: () => [
          LoginLoading(),
          LoginInitial(),
        ],
        verify: (_) {
          verify(() => authenticationRepository.getCurrentUser()).called(1);
        },
      );

      blocTest(
        'should emit LoginFailed '
        'when GetSignedInUser event is added '
        'and repository throws an exception',
        setUp: () {
          when(() => authenticationRepository.getCurrentUser())
              .thenThrow(exception);
        },
        build: () => loginBloc,
        act: (bloc) => bloc.add(GetSignedInUser()),
        expect: () => [
          LoginLoading(),
          LoginFailed(exception.toString()),
        ],
        verify: (_) {
          verify(() => authenticationRepository.getCurrentUser()).called(1);
        },
      );
    });
  });
}
