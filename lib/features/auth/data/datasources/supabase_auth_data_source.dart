import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/supabase_service.dart';
import '../models/auth_tokens_model.dart';
import '../models/login_request.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

/// Supabase implementation of AuthRemoteDataSource
@LazySingleton(as: AuthRemoteDataSource)
class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseService _supabaseService;

  SupabaseAuthRemoteDataSource(this._supabaseService);

  GoTrueClient get _auth => _supabaseService.client.auth;

  @override
  Future<(UserModel, AuthTokensModel)> login(LoginRequest request) async {
    try {
      final response = await _auth.signInWithPassword(
        email: request.email,
        password: request.password,
      );

      if (response.user == null || response.session == null) {
        throw const UnauthorizedException(
          message: 'Нэвтрэх нэр эсвэл нууц үг буруу байна',
        );
      }

      final user = _mapUser(response.user!);
      final tokens = _mapTokens(response.session!);

      debugPrint('SUPABASE AUTH: Login successful for ${user.email}');
      return (user, tokens);
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: 'Нэвтрэхэд алдаа гарлаа: ${e.toString()}');
    }
  }

  @override
  Future<(UserModel, AuthTokensModel)> register(RegisterRequest request) async {
    try {
      final response = await _auth.signUp(
        email: request.email,
        password: request.password,
        data: {
          'name': request.name,
          'phone': request.phone,
        },
      );

      if (response.user == null) {
        throw const ServerException(
          message: 'Бүртгэл амжилтгүй боллоо',
        );
      }

      // Check if email confirmation is required
      if (response.session == null) {
        // Email confirmation required - return user without session
        throw const BadRequestException(
          message: 'Имэйл баталгаажуулах холбоос илгээгдлээ. Имэйлээ шалгана уу.',
        );
      }

      final user = _mapUser(response.user!);
      final tokens = _mapTokens(response.session!);

      debugPrint('SUPABASE AUTH: Registration successful for ${user.email}');
      return (user, tokens);
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw ServerException(message: 'Бүртгүүлэхэд алдаа гарлаа: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
      debugPrint('SUPABASE AUTH: Logout successful');
    } on AuthException catch (e) {
      debugPrint('SUPABASE AUTH: Logout error - ${e.message}');
      // Don't throw on logout errors, just log them
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final user = _supabaseService.currentUser;
    if (user == null) {
      throw const UnauthorizedException(
        message: 'Нэвтрэлт хийгдээгүй байна',
      );
    }

    // Fetch additional user data from profiles table if exists
    try {
      final profileData = await _supabaseService
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (profileData != null) {
        return UserModel(
          id: user.id,
          email: user.email ?? '',
          name: profileData['name'] as String? ??
              user.userMetadata?['name'] as String? ??
              'Хэрэглэгч',
          phone: profileData['phone'] as String? ??
              user.userMetadata?['phone'] as String?,
          avatarUrl: profileData['avatar_url'] as String?,
          role: profileData['role'] as String?,
          createdAt: DateTime.tryParse(user.createdAt),
        );
      }
    } catch (e) {
      debugPrint('SUPABASE AUTH: Could not fetch profile - ${e.toString()}');
    }

    // Return basic user info from auth
    return _mapUser(user);
  }

  @override
  Future<AuthTokensModel> refreshToken() async {
    try {
      final response = await _auth.refreshSession();

      if (response.session == null) {
        throw const TokenRefreshException(
          message: 'Сессийн хугацаа дууссан. Дахин нэвтэрнэ үү',
        );
      }

      debugPrint('SUPABASE AUTH: Token refreshed successfully');
      return _mapTokens(response.session!);
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      if (e is AppException) rethrow;
      throw const TokenRefreshException();
    }
  }

  /// Map Supabase User to UserModel
  UserModel _mapUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String? ?? 'Хэрэглэгч',
      phone: user.userMetadata?['phone'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      role: user.userMetadata?['role'] as String?,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }

  /// Map Supabase Session to AuthTokensModel
  AuthTokensModel _mapTokens(Session session) {
    return AuthTokensModel(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
      expiresAt: session.expiresAt != null
          ? DateTime.fromMillisecondsSinceEpoch(session.expiresAt! * 1000)
          : null,
    );
  }

  /// Map Supabase AuthException to app exceptions
  AppException _mapAuthException(AuthException e) {
    final message = e.message.toLowerCase();

    // Invalid credentials
    if (message.contains('invalid login credentials') ||
        message.contains('invalid email or password')) {
      return const UnauthorizedException(
        message: 'Нэвтрэх нэр эсвэл нууц үг буруу байна',
      );
    }

    // User not found
    if (message.contains('user not found')) {
      return const NotFoundException(
        message: 'Хэрэглэгч олдсонгүй',
      );
    }

    // Email already registered
    if (message.contains('user already registered') ||
        message.contains('email already in use')) {
      return const BadRequestException(
        message: 'Энэ имэйл хаяг бүртгэлтэй байна',
      );
    }

    // Weak password
    if (message.contains('password')) {
      return const BadRequestException(
        message: 'Нууц үг хангалттай хүчтэй биш байна. Дор хаяж 6 тэмдэгт оруулна уу',
      );
    }

    // Invalid email
    if (message.contains('email')) {
      return const BadRequestException(
        message: 'Имэйл хаяг буруу байна',
      );
    }

    // Rate limited
    if (message.contains('rate limit') || message.contains('too many requests')) {
      return const ServerException(
        message: 'Хэт олон удаа оролдлоо. Түр хүлээнэ үү',
      );
    }

    // Session expired
    if (message.contains('session') || message.contains('token')) {
      return const TokenRefreshException(
        message: 'Сессийн хугацаа дууссан. Дахин нэвтэрнэ үү',
      );
    }

    // Default error
    return ServerException(
      message: 'Нэвтрэлтийн алдаа: ${e.message}',
    );
  }
}
