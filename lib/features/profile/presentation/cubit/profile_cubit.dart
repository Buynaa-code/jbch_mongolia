import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/settings_usecases.dart';
import 'profile_state.dart';

/// Cubit for managing Profile feature state
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfile;
  final GetFavoriteSongsUseCase _getFavoriteSongs;
  final GetFavoriteVersesUseCase _getFavoriteVerses;
  final GetThemeModeUseCase _getThemeMode;
  final SetThemeModeUseCase _setThemeMode;
  final GetNotificationsEnabledUseCase _getNotificationsEnabled;
  final SetNotificationsEnabledUseCase _setNotificationsEnabled;
  final LogoutUseCase _logout;

  ProfileCubit(
    this._getProfile,
    this._getFavoriteSongs,
    this._getFavoriteVerses,
    this._getThemeMode,
    this._setThemeMode,
    this._getNotificationsEnabled,
    this._setNotificationsEnabled,
    this._logout,
  ) : super(const ProfileInitial());

  /// Load profile data
  Future<void> loadProfile() async {
    emit(const ProfileLoading());

    try {
      // Load settings from local storage
      final themeModeResult = await _getThemeMode();
      final notificationsResult = await _getNotificationsEnabled();

      final themeMode = themeModeResult.fold(
        (_) => ThemeMode.system,
        (mode) => mode,
      );
      final notificationsEnabled = notificationsResult.fold(
        (_) => true,
        (enabled) => enabled,
      );

      // Load profile from API
      final profileResult = await _getProfile();

      await profileResult.fold(
        (failure) async {
          emit(ProfileError(failure.message));
        },
        (user) async {
          // Load favorites
          final songsResult = await _getFavoriteSongs();
          final versesResult = await _getFavoriteVerses();

          final favoriteSongs = songsResult.fold(
            (_) => <dynamic>[],
            (songs) => songs,
          );

          final favoriteVerses = versesResult.fold(
            (_) => <dynamic>[],
            (verses) => verses,
          );

          emit(ProfileLoaded(
            user: user,
            favoriteVerses: List.from(favoriteVerses),
            favoriteSongs: List.from(favoriteSongs),
            themeMode: themeMode,
            notificationsEnabled: notificationsEnabled,
          ));
        },
      );
    } catch (e) {
      emit(ProfileError('Профайл ачаалахад алдаа гарлаа: $e'));
    }
  }

  /// Change theme mode
  Future<void> changeThemeMode(ThemeMode mode) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      await _setThemeMode(mode);
      emit(currentState.copyWith(themeMode: mode));
    }
  }

  /// Toggle notifications
  Future<void> toggleNotifications() async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      final newValue = !currentState.notificationsEnabled;
      await _setNotificationsEnabled(newValue);
      emit(currentState.copyWith(notificationsEnabled: newValue));
    }
  }

  /// Logout user
  Future<void> logout() async {
    await _logout();
    emit(const ProfileInitial());
  }

  /// Refresh profile data
  Future<void> refresh() async {
    await loadProfile();
  }
}
