import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

/// Cubit for managing authentication state
@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final AuthRepository _authRepository;

  AuthCubit(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
    this._authRepository,
  ) : super(const AuthInitial());

  /// Check if user is already logged in
  Future<void> checkAuthStatus() async {
    emit(const AuthChecking());

    final isLoggedIn = await _authRepository.isLoggedIn();
    if (!isLoggedIn) {
      emit(const AuthUnauthenticated());
      return;
    }

    // Try to get current user
    final result = await _getCurrentUserUseCase();
    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (data) => emit(AuthAuthenticated(data.$1)),
    );
  }

  /// Register a new user
  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    emit(const AuthLoading());

    final result = await _registerUseCase(
      RegisterParams(
        email: email,
        password: password,
        name: name,
        phone: phone,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (data) => emit(AuthAuthenticated(data.$1)),
    );
  }

  /// Logout the current user
  Future<void> logout() async {
    emit(const AuthLoading());

    final result = await _logoutUseCase();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }

  /// Reset error state
  void resetError() {
    if (state is AuthError) {
      emit(const AuthUnauthenticated());
    }
  }
}
