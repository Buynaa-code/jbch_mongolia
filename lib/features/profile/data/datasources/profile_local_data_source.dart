import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileLocalDataSource {
  /// Get theme mode preference
  Future<ThemeMode> getThemeMode();

  /// Set theme mode preference
  Future<void> setThemeMode(ThemeMode mode);

  /// Get notifications enabled preference
  Future<bool> getNotificationsEnabled();

  /// Set notifications enabled preference
  Future<void> setNotificationsEnabled(bool enabled);
}

@LazySingleton(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _themeModeKey = 'theme_mode';
  static const String _notificationsEnabledKey = 'notifications_enabled';

  final SharedPreferences _prefs;

  ProfileLocalDataSourceImpl(this._prefs);

  @override
  Future<ThemeMode> getThemeMode() async {
    final value = _prefs.getString(_themeModeKey);
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(_themeModeKey, value);
  }

  @override
  Future<bool> getNotificationsEnabled() async {
    return _prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  @override
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_notificationsEnabledKey, enabled);
  }
}
