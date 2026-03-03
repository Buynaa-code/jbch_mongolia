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
  void onRequest(
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
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Don't try to refresh if we're already on refresh endpoint
      if (err.requestOptions.path.contains(ApiConstants.refreshToken)) {
        await _tokenStorage.clearTokens();
        handler.next(err);
        return;
      }

      // Try to refresh the token
      final refreshed = await _tryRefreshToken();
      if (refreshed) {
        // Retry the original request with new token
        try {
          final accessToken = await _tokenStorage.getAccessToken();
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $accessToken';

          final response = await _dio.fetch(options);
          handler.resolve(response);
          return;
        } catch (e) {
          debugPrint('Failed to retry request after token refresh: $e');
        }
      }

      // If refresh failed, clear tokens
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
        await _tokenStorage.saveTokens(
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'] ?? refreshToken,
          expiry: data['expiresAt'] != null
              ? DateTime.parse(data['expiresAt'])
              : null,
        );
        return true;
      }
    } catch (e) {
      debugPrint('Token refresh failed: $e');
    }
    return false;
  }
}
