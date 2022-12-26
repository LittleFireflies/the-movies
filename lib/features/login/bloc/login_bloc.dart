import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/services/auth/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginWithGoogle>((event, emit) async {
      emit(LoginLoading());
      try {
        await _authenticationRepository.signInWithGoogle();

        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailed(e.toString()));
      }
    });
  }
}
