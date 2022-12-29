import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movies/services/auth/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial()) {
    on<LoginWithGoogle>((event, emit) => _onLoginWithGoogle(emit));
    on<GetSignedInUser>((event, emit) => _onGetSignedInUser(emit));
    on<Logout>((event, emit) => _onLogout(emit));
  }

  Future<void> _onLoginWithGoogle(Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final userCredential = await _authenticationRepository.signInWithGoogle();

      emit(LoginSuccess(userCredential.user));
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }

  Future<void> _onGetSignedInUser(Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final user = await _authenticationRepository.getCurrentUser();

      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginInitial());
      }
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }

  Future<void> _onLogout(Emitter<LoginState> emit) async {
    await _authenticationRepository.signOut();

    emit(LogoutSuccess());
  }
}
