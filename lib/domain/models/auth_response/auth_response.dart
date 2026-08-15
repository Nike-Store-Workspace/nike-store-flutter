import 'user.dart';

class AuthResponse {
  String? token;
  String? refreshToken;
  User? user;

  AuthResponse({this.token, this.refreshToken, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    token: json['token'] as String?,
    refreshToken: json['refresh_token'] as String?,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'refresh_token': refreshToken,
    'user': user?.toJson(),
  };
}
