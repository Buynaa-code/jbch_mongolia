/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

/// Exception thrown when server returns an error response
class ServerException extends AppException {
  const ServerException({
    super.message = 'Серверийн алдаа гарлаа',
    super.statusCode,
  });
}

/// Exception thrown when there is no internet connection
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Интернет холболт байхгүй байна',
  });
}

/// Exception thrown when local cache operation fails
class CacheException extends AppException {
  const CacheException({
    super.message = 'Локал санах ойн алдаа гарлаа',
  });
}

/// Exception thrown when user is not authorized (401)
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Нэвтрэх эрхгүй байна. Дахин нэвтэрнэ үү',
    super.statusCode = 401,
  });
}

/// Exception thrown when resource is not found (404)
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Хайсан зүйл олдсонгүй',
    super.statusCode = 404,
  });
}

/// Exception thrown when request is invalid (400)
class BadRequestException extends AppException {
  const BadRequestException({
    super.message = 'Буруу хүсэлт илгээгдлээ',
    super.statusCode = 400,
  });
}

/// Exception thrown when token refresh fails
class TokenRefreshException extends AppException {
  const TokenRefreshException({
    super.message = 'Нэвтрэлт дуусав. Дахин нэвтэрнэ үү',
    super.statusCode = 401,
  });
}
