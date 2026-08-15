part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitialEvent extends AuthEvent {
  const AuthInitialEvent();
}

class AuthLoginButtonIsClickedEvent extends AuthEvent {
  final LoginRequest request;

  const AuthLoginButtonIsClickedEvent({required this.request});
}

class AuthSignUpButtonIsClickedEvent extends AuthEvent {
  final SignupRequest request;

  const AuthSignUpButtonIsClickedEvent({required this.request});
}

class AuthModeChangeIsClickedEvent extends AuthEvent {}
