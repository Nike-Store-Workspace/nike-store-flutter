import 'package:nike_store_flutter/domain/models/login_request.dart';
import 'package:nike_store_flutter/domain/models/signup_request.dart';

abstract interface class IAuthRepository {
  Future<void> login(LoginRequest request);
  Future<void> singUp(SignupRequest request);
  Future<void> refreshToken(String refreshToken);
  Future<void> signOut();
}
