part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User? user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailed extends LoginState {
  final String errorMessage;

  const LoginFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LogoutSuccess extends LoginState {}
