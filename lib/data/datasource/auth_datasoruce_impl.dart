import 'package:dio/dio.dart';
import 'package:nike_store_flutter/data/common/api_response.dart';
import 'package:nike_store_flutter/data/common/http_response_validator.dart';
import 'package:nike_store_flutter/domain/datasource/auth_datasource.dart';
import 'package:nike_store_flutter/domain/models/auth_response/auth_response.dart';
import 'package:nike_store_flutter/domain/models/login_request.dart';
import 'package:nike_store_flutter/domain/models/signup_request.dart';

class AuthDatasourceImpl with HttpResponseValidator implements IAuthDatasource {
  final Dio _httpClient;

  AuthDatasourceImpl({required this._httpClient});

  @override
  Future<ApiResponse<AuthResponse>> login(LoginRequest request) async {
    final response = await _httpClient.post('login', data: request.toJson());
    validateHttpResponse(response);
    final ApiResponse<AuthResponse> res = ApiResponse.fromJson(response.data, (
      json,
    ) {
      return AuthResponse.fromJson(json);
    });
    return res;
  }

  @override
  Future<ApiResponse<AuthResponse>> refreshToken(String refreshToken) async {
    final response = await _httpClient.post(
      'refresh_token',
      data: {"refresh_token": refreshToken},
    );

    validateHttpResponse(response);
    return ApiResponse.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(response.data),
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> singUp(SignupRequest request) async {
    final response = await _httpClient.post('signup', data: request);
    validateHttpResponse(response);
    return ApiResponse.fromJson(
      response.data,
      (json) => AuthResponse.fromJson(response.data),
    );
  }
}
