import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';
import 'api_constants.dart';
import 'auth_interceptor.dart';
import 'token_storage.dart';

/// Dio HTTP client wrapper with error handling
@lazySingleton
class DioClient {
  late final Dio _dio;
  final TokenStorage _tokenStorage;

  DioClient(this._tokenStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add auth interceptor
    _dio.interceptors.add(
      AuthInterceptor(
        tokenStorage: _tokenStorage,
        dio: _dio,
      ),
    );

    // Add logging interceptor in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      );
    }
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Handle Dio exceptions and convert to app exceptions
  AppException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          message: 'Холболт удааширлаа. Дахин оролдоно уу',
        );

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _handleStatusCode(e.response);

      case DioExceptionType.cancel:
        return const ServerException(message: 'Хүсэлт цуцлагдлаа');

      default:
        return ServerException(
          message: e.message ?? 'Тодорхойгүй алдаа гарлаа',
        );
    }
  }

  /// Handle HTTP status codes
  AppException _handleStatusCode(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    String? message;
    if (data is Map<String, dynamic>) {
      message = data['message'] as String?;
    }

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: message ?? 'Буруу хүсэлт илгээгдлээ',
        );
      case 401:
        return UnauthorizedException(
          message: message ?? 'Нэвтрэх эрхгүй байна',
        );
      case 404:
        return NotFoundException(
          message: message ?? 'Хайсан зүйл олдсонгүй',
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: message ?? 'Серверийн алдаа гарлаа',
          statusCode: statusCode,
        );
      default:
        return ServerException(
          message: message ?? 'Алдаа гарлаа',
          statusCode: statusCode,
        );
    }
  }
}
