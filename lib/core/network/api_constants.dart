import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;

/// API constants and endpoint definitions
abstract final class ApiConstants {
  /// Base URL for the API
  /// For real devices, use your computer's IP address
  /// For emulators: Android uses 10.0.2.2, iOS uses localhost
  static String get baseUrl {
    // TODO: Change to your computer's IP for real device testing
    // return 'http://192.168.1.112:5001/api';

    // Web platform uses localhost
    if (kIsWeb) {
      return 'http://localhost:5001/api';
    }

    // Android emulator uses 10.0.2.2
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:5001/api';
    }

    // iOS and others use localhost
    return 'http://localhost:5001/api';
  }

  /// Use this for real device testing
  static const String realDeviceBaseUrl = 'http://192.168.1.112:5001/api';

  /// Connection timeout in milliseconds
  static const int connectionTimeout = 30000;

  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;

  // ============ Auth Endpoints ============
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';

  // ============ Events Endpoints ============
  static const String events = '/events';
  static const String upcomingEvents = '/events/upcoming';
  static String eventById(String id) => '/events/$id';
  static String registerForEvent(String id) => '/events/$id/register';

  // ============ Songs Endpoints ============
  static const String songs = '/songs';
  static const String featuredSongs = '/songs/featured';
  static String songById(String id) => '/songs/$id';
  static String toggleSongFavorite(String id) => '/songs/$id/favorite';

  // ============ Verses Endpoints ============
  static const String verses = '/verses';
  static const String verseOfWeek = '/verses/verse-of-week';
  static String verseById(String id) => '/verses/$id';
  static String toggleVerseFavorite(String id) => '/verses/$id/favorite';

  // ============ Sermons Endpoints ============
  static const String sermons = '/sermons';
  static const String recentSermons = '/sermons/recent';
  static String sermonById(String id) => '/sermons/$id';
  static String toggleSermonFavorite(String id) => '/sermons/$id/favorite';

  // ============ Programs Endpoints ============
  static const String weeklyProgram = '/programs/current-week';

  // ============ Announcements Endpoints ============
  static const String announcements = '/announcements';
  static const String activeAnnouncements = '/announcements/active';

  // ============ Sunday Schedule Endpoints ============
  static const String sundayScheduleCurrent = '/sunday-schedules/current';
  static const String sundayScheduleNext = '/sunday-schedules/next';
  static const String sundayScheduleWeekly = '/sunday-schedules/weekly';

  // ============ Users Endpoints ============
  static const String userProfile = '/users/profile';
  static const String userFavoriteSongs = '/users/favorites/songs';
  static const String userFavoriteVerses = '/users/favorites/verses';
  static const String userFavoriteSermons = '/users/favorites/sermons';
}
