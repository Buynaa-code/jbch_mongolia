import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../entities/user_profile.dart';

/// Abstract profile repository interface
abstract class ProfileRepository {
  /// Get user profile
  Future<Either<Failure, UserProfile>> getProfile();

  /// Update user profile
  Future<Either<Failure, UserProfile>> updateProfile({
    String? name,
    String? email,
    String? profileImageUrl,
  });

  /// Get user's favorite songs
  Future<Either<Failure, List<Song>>> getFavoriteSongs();

  /// Get user's favorite verses
  Future<Either<Failure, List<Verse>>> getFavoriteVerses();

  /// Update theme mode preference
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode);

  /// Get current theme mode
  Future<Either<Failure, ThemeMode>> getThemeMode();

  /// Update notifications enabled preference
  Future<Either<Failure, void>> setNotificationsEnabled(bool enabled);

  /// Get notifications enabled status
  Future<Either<Failure, bool>> getNotificationsEnabled();

  /// Logout user
  Future<Either<Failure, void>> logout();
}
