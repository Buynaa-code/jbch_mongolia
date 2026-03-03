import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/sermon.dart';
import '../entities/song.dart';
import '../entities/verse.dart';
import '../repositories/library_repository.dart';

/// Use case for toggling song favorite
@lazySingleton
class ToggleSongFavoriteUseCase {
  final LibraryRepository _repository;

  ToggleSongFavoriteUseCase(this._repository);

  Future<Either<Failure, Song>> call(String id) {
    return _repository.toggleSongFavorite(id);
  }
}

/// Use case for toggling verse favorite
@lazySingleton
class ToggleVerseFavoriteUseCase {
  final LibraryRepository _repository;

  ToggleVerseFavoriteUseCase(this._repository);

  Future<Either<Failure, Verse>> call(String id) {
    return _repository.toggleVerseFavorite(id);
  }
}

/// Use case for toggling sermon favorite
@lazySingleton
class ToggleSermonFavoriteUseCase {
  final LibraryRepository _repository;

  ToggleSermonFavoriteUseCase(this._repository);

  Future<Either<Failure, Sermon>> call(String id) {
    return _repository.toggleSermonFavorite(id);
  }
}
