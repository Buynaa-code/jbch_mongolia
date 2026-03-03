import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/verse.dart';
import '../repositories/library_repository.dart';

/// Use case for getting all verses
@lazySingleton
class GetVersesUseCase {
  final LibraryRepository _repository;

  GetVersesUseCase(this._repository);

  Future<Either<Failure, List<Verse>>> call() {
    return _repository.getVerses();
  }
}

/// Use case for getting verse of the week
@lazySingleton
class GetVerseOfWeekUseCase {
  final LibraryRepository _repository;

  GetVerseOfWeekUseCase(this._repository);

  Future<Either<Failure, Verse>> call() {
    return _repository.getVerseOfWeek();
  }
}
