import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

/// State for the Auth feature
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state - checking if user is logged in
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Checking authentication status
final class AuthChecking extends AuthState {
  const AuthChecking();
}

/// User is not authenticated
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Authentication in progress (login/register)
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// User is authenticated
final class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Authentication error
final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
