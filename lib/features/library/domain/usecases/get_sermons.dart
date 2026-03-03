import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/sermon.dart';
import '../repositories/library_repository.dart';

/// Use case for getting all sermons
@lazySingleton
class GetSermonsUseCase {
  final LibraryRepository _repository;

  GetSermonsUseCase(this._repository);

  Future<Either<Failure, List<Sermon>>> call() {
    return _repository.getSermons();
  }
}

/// Use case for getting recent sermons
@lazySingleton
class GetRecentSermonsUseCase {
  final LibraryRepository _repository;

  GetRecentSermonsUseCase(this._repository);

  Future<Either<Failure, List<Sermon>>> call() {
    return _repository.getRecentSermons();
  }
}
