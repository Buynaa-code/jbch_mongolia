import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/song.dart';
import '../repositories/library_repository.dart';

/// Use case for getting all songs
@lazySingleton
class GetSongsUseCase {
  final LibraryRepository _repository;

  GetSongsUseCase(this._repository);

  Future<Either<Failure, List<Song>>> call() {
    return _repository.getSongs();
  }
}
