import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/domain/models/auth_response/auth_response.dart';
import 'package:nike_store_flutter/domain/models/login_request.dart';
import 'package:nike_store_flutter/domain/models/signup_request.dart';

abstract interface class IAuthDatasource {
  Future<ApiResponse<AuthResponse>> login(LoginRequest request);
  Future<ApiResponse<AuthResponse>> singUp(SignupRequest request);
  Future<ApiResponse<AuthResponse>> refreshToken(String refreshToken);
}
