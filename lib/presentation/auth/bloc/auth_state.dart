part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState({required this.isLoginMode});
  final bool isLoginMode;

  @override
  List<Object> get props => [isLoginMode];
}

final class AuthInitialState extends AuthState {
  const AuthInitialState({required super.isLoginMode});
}

class AuthErrorState extends AuthState {
  final AppException exception;
  const AuthErrorState({required super.isLoginMode, required this.exception});
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState({required super.isLoginMode});
}

class AuthSuccessState extends AuthState {
  const AuthSuccessState({required super.isLoginMode});
}
