import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_tokens.dart';
import '../entities/user.dart';

/// Abstract repository interface for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, (User, AuthTokens)>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<Either<Failure, (User, AuthTokens)>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  });

  /// Logout the current user
  Future<Either<Failure, void>> logout();

  /// Get current user profile
  Future<Either<Failure, User>> getCurrentUser();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Refresh the access token
  Future<Either<Failure, AuthTokens>> refreshToken();
}
