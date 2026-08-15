import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/domain/models/login_request.dart';
import 'package:nike_store_flutter/domain/models/signup_request.dart';
import 'package:nike_store_flutter/domain/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository repository;
  bool isLoginMode;
  AuthBloc({this.isLoginMode = true, required this.repository})
    : super(AuthInitialState(isLoginMode: isLoginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthLoginButtonIsClickedEvent ||
            event is AuthSignUpButtonIsClickedEvent) {
          emit(AuthLoadingState(isLoginMode: isLoginMode));

          if (isLoginMode) {
            await repository.login(
              (event as AuthLoginButtonIsClickedEvent).request,
            );
          } else {
            await repository.singUp(
              (event as AuthSignUpButtonIsClickedEvent).request,
            );
          }
          emit(AuthSuccessState(isLoginMode: isLoginMode));
        } else if (event is AuthModeChangeIsClickedEvent) {
          isLoginMode = !isLoginMode;
          emit(AuthInitialState(isLoginMode: isLoginMode));
        }
      } catch (e) {
        emit(
          AuthErrorState(
            isLoginMode: isLoginMode,
            exception: e.toAppException(),
          ),
        );
      }
    });
  }
}
