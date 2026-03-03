import 'package:injectable/injectable.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/token_storage.dart';
import '../models/auth_tokens_model.dart';
import '../models/login_request.dart';
import '../models/user_model.dart';

/// Remote data source for authentication API calls
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<(UserModel, AuthTokensModel)> login(LoginRequest request);

  /// Register a new user
  Future<(UserModel, AuthTokensModel)> register(RegisterRequest request);

  /// Logout the current user
  Future<void> logout();

  /// Get current user profile
  Future<UserModel> getCurrentUser();

  /// Refresh the access token
  Future<AuthTokensModel> refreshToken();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;
  final TokenStorage _tokenStorage;

  AuthRemoteDataSourceImpl(this._dioClient, this._tokenStorage);

  @override
  Future<(UserModel, AuthTokensModel)> login(LoginRequest request) async {
    final response = await _dioClient.post(
      ApiConstants.login,
      data: request.toJson(),
    );

    final data = response.data as Map<String, dynamic>;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    final tokens =
        AuthTokensModel.fromJson(data['tokens'] as Map<String, dynamic>);

    // Save tokens to secure storage
    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiry: tokens.expiresAt,
    );

    return (user, tokens);
  }

  @override
  Future<(UserModel, AuthTokensModel)> register(RegisterRequest request) async {
    final response = await _dioClient.post(
      ApiConstants.register,
      data: request.toJson(),
    );

    final data = response.data as Map<String, dynamic>;
    final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    final tokens =
        AuthTokensModel.fromJson(data['tokens'] as Map<String, dynamic>);

    // Save tokens to secure storage
    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiry: tokens.expiresAt,
    );

    return (user, tokens);
  }

  @override
  Future<void> logout() async {
    try {
      await _dioClient.post(ApiConstants.logout);
    } finally {
      // Always clear tokens even if API call fails
      await _tokenStorage.clearTokens();
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await _dioClient.get(ApiConstants.me);
    final data = response.data as Map<String, dynamic>;
    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  @override
  Future<AuthTokensModel> refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();

    final response = await _dioClient.post(
      ApiConstants.refreshToken,
      data: {'refreshToken': refreshToken},
    );

    final data = response.data as Map<String, dynamic>;
    final tokens = AuthTokensModel.fromJson(data);

    // Save new tokens
    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiry: tokens.expiresAt,
    );

    return tokens;
  }
}
