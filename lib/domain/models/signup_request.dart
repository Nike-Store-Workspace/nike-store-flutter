class SignupRequest {
  String email;
  String password;
  String fullName;
  String confirmPassword;

  SignupRequest({
    required this.email,
    required this.password,
    required this.fullName,
    required this.confirmPassword,
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
    email: json['email'] as String,
    password: json['password'] as String,
    fullName: json['full_name'] as String,
    confirmPassword: json['confirm_password'] as String,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'full_name': fullName,
    'confirm_password': confirmPassword,
  };
}
