import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../events/domain/entities/event.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../entities/weekly_program.dart';

/// Abstract repository interface for home page data
abstract class HomeRepository {
  /// Get upcoming seminars/events for the carousel
  Future<Either<Failure, List<Event>>> getUpcomingSeminars();

  /// Get current week's program
  Future<Either<Failure, List<WeeklyProgramItem>>> getWeeklyProgram();

  /// Get the memory verse of the week
  Future<Either<Failure, Verse>> getMemoryVerse();

  /// Get featured/recent songs for quick play
  Future<Either<Failure, List<Song>>> getFeaturedSongs();
}
