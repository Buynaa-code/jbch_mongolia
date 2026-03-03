import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Secure storage for authentication tokens
@lazySingleton
class TokenStorage {
  final FlutterSecureStorage _secureStorage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';

  TokenStorage(this._secureStorage);

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  /// Save token expiry time
  Future<void> saveTokenExpiry(DateTime expiry) async {
    await _secureStorage.write(
      key: _tokenExpiryKey,
      value: expiry.toIso8601String(),
    );
  }

  /// Get token expiry time
  Future<DateTime?> getTokenExpiry() async {
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString != null) {
      return DateTime.tryParse(expiryString);
    }
    return null;
  }

  /// Check if token is expired
  Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  /// Save all tokens at once
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    DateTime? expiry,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
      if (expiry != null) saveTokenExpiry(expiry),
    ]);
  }

  /// Clear all tokens (used for logout)
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
      _secureStorage.delete(key: _tokenExpiryKey),
    ]);
  }

  /// Check if user has tokens stored
  Future<bool> hasTokens() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
}
