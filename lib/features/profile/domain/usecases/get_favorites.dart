import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class GetFavoriteSongsUseCase {
  final ProfileRepository repository;

  GetFavoriteSongsUseCase(this.repository);

  Future<Either<Failure, List<Song>>> call() {
    return repository.getFavoriteSongs();
  }
}

@lazySingleton
class GetFavoriteVersesUseCase {
  final ProfileRepository repository;

  GetFavoriteVersesUseCase(this.repository);

  Future<Either<Failure, List<Verse>>> call() {
    return repository.getFavoriteVerses();
  }
}
