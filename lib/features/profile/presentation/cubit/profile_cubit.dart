import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/mock_profile_data.dart';
import 'profile_state.dart';

/// Cubit for managing Profile feature state
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());

  /// Load profile data
  Future<void> loadProfile() async {
    emit(const ProfileLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      emit(ProfileLoaded(
        user: MockProfileData.currentUser,
        favoriteVerses: MockProfileData.favoriteVerses,
        favoriteSongs: MockProfileData.favoriteSongs,
      ));
    } catch (e) {
      emit(ProfileError('Профайл ачаалахад алдаа гарлаа: $e'));
    }
  }

  /// Change theme mode
  void changeThemeMode(ThemeMode mode) {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(currentState.copyWith(themeMode: mode));
    }
  }

  /// Toggle notifications
  void toggleNotifications() {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(currentState.copyWith(
        notificationsEnabled: !currentState.notificationsEnabled,
      ));
    }
  }

  /// Refresh profile data
  Future<void> refresh() async {
    await loadProfile();
  }
}
