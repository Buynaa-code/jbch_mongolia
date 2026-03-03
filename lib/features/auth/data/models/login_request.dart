import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

/// Request model for login API
@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

/// Request model for register API
@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  final String name;
  final String? phone;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
