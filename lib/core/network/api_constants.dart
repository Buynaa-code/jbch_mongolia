import 'dart:io';

/// API constants and endpoint definitions
abstract final class ApiConstants {
  /// Base URL for the API
  /// Uses 10.0.2.2 for Android emulator, localhost for iOS simulator
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5001/api';
    }
    return 'http://localhost:5001/api';
  }

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

  // ============ Users Endpoints ============
  static const String userProfile = '/users/profile';
  static const String userFavoriteSongs = '/users/favorites/songs';
  static const String userFavoriteVerses = '/users/favorites/verses';
  static const String userFavoriteSermons = '/users/favorites/sermons';
}
