import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../events/domain/entities/event.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../entities/weekly_program.dart';
import '../repositories/home_repository.dart';

/// Use case for getting upcoming seminars
@lazySingleton
class GetUpcomingSeminarsUseCase {
  final HomeRepository _repository;

  GetUpcomingSeminarsUseCase(this._repository);

  Future<Either<Failure, List<Event>>> call() {
    return _repository.getUpcomingSeminars();
  }
}

/// Use case for getting weekly program
@lazySingleton
class GetWeeklyProgramUseCase {
  final HomeRepository _repository;

  GetWeeklyProgramUseCase(this._repository);

  Future<Either<Failure, List<WeeklyProgramItem>>> call() {
    return _repository.getWeeklyProgram();
  }
}

/// Use case for getting memory verse
@lazySingleton
class GetMemoryVerseUseCase {
  final HomeRepository _repository;

  GetMemoryVerseUseCase(this._repository);

  Future<Either<Failure, Verse>> call() {
    return _repository.getMemoryVerse();
  }
}

/// Use case for getting featured songs
@lazySingleton
class GetFeaturedSongsUseCase {
  final HomeRepository _repository;

  GetFeaturedSongsUseCase(this._repository);

  Future<Either<Failure, List<Song>>> call() {
    return _repository.getFeaturedSongs();
  }
}
