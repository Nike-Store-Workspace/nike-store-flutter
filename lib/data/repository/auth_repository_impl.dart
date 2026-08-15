import 'package:flutter/material.dart';
import 'package:nike_store_flutter/common/exception.dart';
import 'package:nike_store_flutter/common/http_client.dart';
import 'package:nike_store_flutter/data/datasource/auth_datasoruce_impl.dart';
import 'package:nike_store_flutter/domain/datasource/auth_datasource.dart';
import 'package:nike_store_flutter/domain/models/auth_response/auth_response.dart';
import 'package:nike_store_flutter/domain/models/login_request.dart';
import 'package:nike_store_flutter/domain/models/signup_request.dart';
import 'package:nike_store_flutter/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepositoryImpl(
  datasource: AuthDatasourceImpl(httpClient: httpClient),
);

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthDatasource datasource;
  static final ValueNotifier<AuthResponse?> authChangeNotifier =
      ValueNotifier<AuthResponse?>(null);

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<void> login(LoginRequest request) async {
    final response = await datasource.login(request);
    if (response.success) {
      _persistAuthTokens(response.data!);
    } else {
      throw AppException(
        messageFa: response.messageFa,
        messageEn: response.messageEn,
      );
    }
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    final response = await datasource.refreshToken(refreshToken);
    if (response.success) {
      _persistAuthTokens(response.data!);
    } else {
      throw AppException(
        messageFa: response.messageFa,
        messageEn: response.messageEn,
      );
    }
  }

  @override
  Future<void> singUp(SignupRequest request) async {
    final response = await datasource.singUp(request);
    if (response.success) {
      _persistAuthTokens(response.data!);
    } else {
      throw AppException(
        messageFa: response.messageFa,
        messageEn: response.messageEn,
      );
    }
    return;
  }

  Future<void> _persistAuthTokens(AuthResponse response) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (response.token != null && response.refreshToken != null) {
      await sharedPreferences.setString('access_token', response.token!);
      await sharedPreferences.setString(
        'refresh_token',
        response.refreshToken!,
      );
      loadAuthInfo();
      return;
    }
    throw AppException(
      messageEn:
          'Failed to persist auth tokens, token is null or refresh token is null',
      messageFa: 'خطا در ورود به حساب کاربری',
    );
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String accessToken =
        sharedPreferences.getString('access_token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthResponse(
        token: accessToken,
        refreshToken: refreshToken,
        user: null,
      );
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
