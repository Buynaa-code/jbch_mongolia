import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sermon.dart';
import '../entities/song.dart';
import '../entities/verse.dart';

/// Abstract repository interface for library operations (songs, verses, sermons)
abstract class LibraryRepository {
  // ============ Songs ============

  /// Get all songs
  Future<Either<Failure, List<Song>>> getSongs();

  /// Get featured songs
  Future<Either<Failure, List<Song>>> getFeaturedSongs();

  /// Get song by id
  Future<Either<Failure, Song>> getSongById(String id);

  /// Toggle song favorite
  Future<Either<Failure, Song>> toggleSongFavorite(String id);

  /// Search songs
  Future<Either<Failure, List<Song>>> searchSongs(String query);

  // ============ Verses ============

  /// Get all verses
  Future<Either<Failure, List<Verse>>> getVerses();

  /// Get verse of the week
  Future<Either<Failure, Verse>> getVerseOfWeek();

  /// Get verse by id
  Future<Either<Failure, Verse>> getVerseById(String id);

  /// Toggle verse favorite
  Future<Either<Failure, Verse>> toggleVerseFavorite(String id);

  /// Search verses
  Future<Either<Failure, List<Verse>>> searchVerses(String query);

  // ============ Sermons ============

  /// Get all sermons
  Future<Either<Failure, List<Sermon>>> getSermons();

  /// Get recent sermons
  Future<Either<Failure, List<Sermon>>> getRecentSermons();

  /// Get sermon by id
  Future<Either<Failure, Sermon>> getSermonById(String id);

  /// Toggle sermon favorite
  Future<Either<Failure, Sermon>> toggleSermonFavorite(String id);

  /// Search sermons
  Future<Either<Failure, List<Sermon>>> searchSermons(String query);
}
