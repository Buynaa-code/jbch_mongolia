import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_constants.dart';
import 'token_storage.dart';

/// Interceptor that handles authentication token injection and refresh
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final Dio _dio;

  AuthInterceptor({
    required TokenStorage tokenStorage,
    required Dio dio,
  })  : _tokenStorage = tokenStorage,
        _dio = dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for login and register endpoints
    final noAuthEndpoints = [
      ApiConstants.login,
      ApiConstants.register,
      ApiConstants.refreshToken,
    ];

    final isNoAuthEndpoint = noAuthEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );

    if (!isNoAuthEndpoint) {
      final accessToken = await _tokenStorage.getAccessToken();
      debugPrint('AuthInterceptor: Request to ${options.path}');
      debugPrint('AuthInterceptor: Token retrieved: ${accessToken != null ? "yes (${accessToken.length} chars)" : "null"}');
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
        debugPrint('AuthInterceptor: Token added to request');
      } else {
        debugPrint('AuthInterceptor: No token available');
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      debugPrint('AuthInterceptor: 401 error received');

      // Don't try to refresh if we're already on refresh endpoint
      if (err.requestOptions.path.contains(ApiConstants.refreshToken)) {
        debugPrint('AuthInterceptor: Refresh token endpoint failed, clearing tokens');
        await _tokenStorage.clearTokens();
        handler.next(err);
        return;
      }

      // Try to refresh the token
      debugPrint('AuthInterceptor: Attempting token refresh');
      final refreshed = await _tryRefreshToken();
      if (refreshed) {
        debugPrint('AuthInterceptor: Token refreshed successfully, retrying request');
        // Retry the original request with new token
        try {
          final accessToken = await _tokenStorage.getAccessToken();
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $accessToken';

          final response = await _dio.fetch(options);
          handler.resolve(response);
          return;
        } catch (e) {
          debugPrint('AuthInterceptor: Failed to retry request after token refresh: $e');
        }
      }

      // If refresh failed, clear tokens
      debugPrint('AuthInterceptor: Token refresh failed, clearing tokens');
      await _tokenStorage.clearTokens();
    }

    handler.next(err);
  }

  /// Attempt to refresh the access token
  Future<bool> _tryRefreshToken() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.refreshToken}',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Safe parsing of response data
        if (data is! Map<String, dynamic>) {
          debugPrint('Token refresh: Invalid response format');
          return false;
        }

        final accessToken = data['accessToken'];
        if (accessToken is! String || accessToken.isEmpty) {
          debugPrint('Token refresh: Missing or invalid accessToken');
          return false;
        }

        final newRefreshToken = data['refreshToken'];
        final expiresAt = data['expiresAt'];

        DateTime? expiry;
        if (expiresAt is String && expiresAt.isNotEmpty) {
          try {
            expiry = DateTime.parse(expiresAt);
          } catch (_) {
            debugPrint('Token refresh: Invalid expiresAt format');
          }
        }

        await _tokenStorage.saveTokens(
          accessToken: accessToken,
          refreshToken: (newRefreshToken is String && newRefreshToken.isNotEmpty)
              ? newRefreshToken
              : refreshToken,
          expiry: expiry,
        );
        return true;
      }
    } catch (e) {
      debugPrint('Token refresh failed: $e');
    }
    return false;
  }
}
