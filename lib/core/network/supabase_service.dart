import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../error/exceptions.dart';

/// Supabase service wrapper with error handling
/// Provides typed access to Supabase client and common operations
@lazySingleton
class SupabaseService {
  /// Get the Supabase client instance
  SupabaseClient get client => Supabase.instance.client;

  /// Get the current authenticated user
  User? get currentUser => client.auth.currentUser;

  /// Get the current session
  Session? get currentSession => client.auth.currentSession;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Get auth state changes stream
  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  /// Execute a database query with error handling
  /// Returns the query builder for the specified table
  SupabaseQueryBuilder from(String table) => client.from(table);

  /// Execute a stored procedure (RPC)
  Future<T> rpc<T>(String functionName, {Map<String, dynamic>? params}) async {
    try {
      final response = await client.rpc(functionName, params: params);
      return response as T;
    } on PostgrestException catch (e) {
      throw _mapPostgrestException(e);
    } catch (e) {
      throw ServerException(message: 'RPC алдаа: ${e.toString()}');
    }
  }

  /// Map Supabase/Postgrest exceptions to app exceptions
  AppException _mapPostgrestException(PostgrestException e) {
    final code = e.code;
    final message = e.message;

    // Authentication errors
    if (code == '401' || code == 'PGRST301') {
      return const UnauthorizedException(
        message: 'Нэвтрэх эрхгүй байна. Дахин нэвтэрнэ үү',
      );
    }

    // Not found errors
    if (code == '404' || code == 'PGRST116') {
      return const NotFoundException(
        message: 'Хайсан мэдээлэл олдсонгүй',
      );
    }

    // Validation/constraint errors
    if (code == '400' || code == '23505' || code == '23503') {
      return BadRequestException(
        message: _getValidationMessage(code, message),
      );
    }

    // Permission denied
    if (code == '42501') {
      return const UnauthorizedException(
        message: 'Энэ үйлдлийг хийх эрхгүй байна',
      );
    }

    // Default server error
    return ServerException(
      message: 'Серверийн алдаа: $message',
    );
  }

  /// Get user-friendly validation message
  String _getValidationMessage(String? code, String message) {
    if (code == '23505') {
      if (message.contains('email')) {
        return 'Энэ имэйл хаяг бүртгэлтэй байна';
      }
      if (message.contains('phone')) {
        return 'Энэ утасны дугаар бүртгэлтэй байна';
      }
      return 'Энэ мэдээлэл давхардаж байна';
    }
    if (code == '23503') {
      return 'Холбоотой мэдээлэл олдсонгүй';
    }
    return 'Буруу мэдээлэл оруулсан байна';
  }
}

/// Extension methods for Supabase queries with error handling
extension SupabaseQueryExtension on SupabaseQueryBuilder {
  /// Select with error handling
  Future<List<Map<String, dynamic>>> selectSafe({
    String columns = '*',
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      PostgrestFilterBuilder<PostgrestList> filterQuery = select(columns);

      // Apply filters
      if (filters != null) {
        for (final entry in filters.entries) {
          filterQuery = filterQuery.eq(entry.key, entry.value);
        }
      }

      // Build transform query with ordering and pagination
      PostgrestTransformBuilder<PostgrestList> transformQuery = filterQuery;

      if (orderBy != null) {
        transformQuery = transformQuery.order(orderBy, ascending: ascending);
      }
      if (limit != null) {
        transformQuery = transformQuery.limit(limit);
      }
      if (offset != null) {
        transformQuery = transformQuery.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await transformQuery;
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw _mapException(e);
    } catch (e) {
      throw ServerException(message: 'Өгөгдөл татахад алдаа гарлаа');
    }
  }

  /// Insert with error handling
  Future<Map<String, dynamic>?> insertSafe(
    Map<String, dynamic> data, {
    bool returnData = true,
  }) async {
    try {
      if (returnData) {
        final response = await insert(data).select().single();
        return response;
      } else {
        await insert(data);
        return null;
      }
    } on PostgrestException catch (e) {
      throw _mapException(e);
    } catch (e) {
      throw ServerException(message: 'Өгөгдөл нэмэхэд алдаа гарлаа');
    }
  }

  /// Update with error handling
  Future<Map<String, dynamic>?> updateSafe(
    Map<String, dynamic> data, {
    required Map<String, dynamic> match,
    bool returnData = true,
  }) async {
    try {
      PostgrestFilterBuilder query = update(data);
      for (final entry in match.entries) {
        query = query.eq(entry.key, entry.value);
      }

      if (returnData) {
        final response = await query.select().single();
        return response;
      } else {
        await query;
        return null;
      }
    } on PostgrestException catch (e) {
      throw _mapException(e);
    } catch (e) {
      throw ServerException(message: 'Өгөгдөл шинэчлэхэд алдаа гарлаа');
    }
  }

  /// Delete with error handling
  Future<void> deleteSafe({required Map<String, dynamic> match}) async {
    try {
      PostgrestFilterBuilder query = delete();
      for (final entry in match.entries) {
        query = query.eq(entry.key, entry.value);
      }
      await query;
    } on PostgrestException catch (e) {
      throw _mapException(e);
    } catch (e) {
      throw ServerException(message: 'Өгөгдөл устгахад алдаа гарлаа');
    }
  }

  AppException _mapException(PostgrestException e) {
    final code = e.code;
    final message = e.message;

    if (code == '401' || code == 'PGRST301') {
      return const UnauthorizedException();
    }
    if (code == '404' || code == 'PGRST116') {
      return const NotFoundException();
    }
    if (code == '23505') {
      return const BadRequestException(message: 'Энэ мэдээлэл давхардаж байна');
    }

    return ServerException(message: 'Серверийн алдаа: $message');
  }
}
