import 'package:equatable/equatable.dart';

/// Authentication tokens entity
class AuthTokens extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime? expiresAt;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresAt];
}
