import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../../domain/entities/user_profile.dart';

/// State for the Profile feature
sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state before data is loaded
final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading state while fetching data
final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Loaded state with profile data
final class ProfileLoaded extends ProfileState {
  final UserProfile user;
  final List<Verse> favoriteVerses;
  final List<Song> favoriteSongs;
  final ThemeMode themeMode;
  final bool notificationsEnabled;

  const ProfileLoaded({
    required this.user,
    required this.favoriteVerses,
    required this.favoriteSongs,
    this.themeMode = ThemeMode.system,
    this.notificationsEnabled = true,
  });

  ProfileLoaded copyWith({
    UserProfile? user,
    List<Verse>? favoriteVerses,
    List<Song>? favoriteSongs,
    ThemeMode? themeMode,
    bool? notificationsEnabled,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      favoriteVerses: favoriteVerses ?? this.favoriteVerses,
      favoriteSongs: favoriteSongs ?? this.favoriteSongs,
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object?> get props => [
        user,
        favoriteVerses,
        favoriteSongs,
        themeMode,
        notificationsEnabled,
      ];
}

/// Error state when something goes wrong
final class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
