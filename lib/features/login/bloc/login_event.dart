part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithGoogle extends LoginEvent {}

class GetSignedInUser extends LoginEvent {}

class Logout extends LoginEvent {}
