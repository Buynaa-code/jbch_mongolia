import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/sermon.dart';
import '../../domain/entities/song.dart';
import '../../domain/entities/verse.dart';
import '../../domain/repositories/library_repository.dart';
import '../datasources/library_remote_data_source.dart';

@LazySingleton(as: LibraryRepository)
class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  LibraryRepositoryImpl(this._remoteDataSource, this._networkInfo);

  // ============ Songs ============

  @override
  Future<Either<Failure, List<Song>>> getSongs() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final songs = await _remoteDataSource.getSongs();
      return Right(songs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Song>>> getFeaturedSongs() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final songs = await _remoteDataSource.getFeaturedSongs();
      return Right(songs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Song>> getSongById(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final song = await _remoteDataSource.getSongById(id);
      return Right(song);
    } on NotFoundException {
      return const Left(NotFoundFailure(message: 'Дуу олдсонгүй'));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Song>> toggleSongFavorite(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final song = await _remoteDataSource.toggleSongFavorite(id);
      return Right(song);
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure(
        message: 'Дуртай дуунд нэмэхийн тулд нэвтрэх шаардлагатай',
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Song>>> searchSongs(String query) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final songs = await _remoteDataSource.getSongs();
      final filteredSongs = songs
          .where((song) =>
              song.title.toLowerCase().contains(query.toLowerCase()) ||
              song.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Right(filteredSongs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ============ Verses ============

  @override
  Future<Either<Failure, List<Verse>>> getVerses() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final verses = await _remoteDataSource.getVerses();
      return Right(verses);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Verse>> getVerseOfWeek() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final verse = await _remoteDataSource.getVerseOfWeek();
      return Right(verse);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Verse>> getVerseById(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final verse = await _remoteDataSource.getVerseById(id);
      return Right(verse);
    } on NotFoundException {
      return const Left(NotFoundFailure(message: 'Ишлэл олдсонгүй'));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Verse>> toggleVerseFavorite(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final verse = await _remoteDataSource.toggleVerseFavorite(id);
      return Right(verse);
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure(
        message: 'Дуртай ишлэлд нэмэхийн тулд нэвтрэх шаардлагатай',
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Verse>>> searchVerses(String query) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final verses = await _remoteDataSource.getVerses();
      final filteredVerses = verses
          .where((verse) =>
              verse.text.toLowerCase().contains(query.toLowerCase()) ||
              verse.book.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Right(filteredVerses);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ============ Sermons ============

  @override
  Future<Either<Failure, List<Sermon>>> getSermons() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final sermons = await _remoteDataSource.getSermons();
      return Right(sermons);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Sermon>>> getRecentSermons() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final sermons = await _remoteDataSource.getRecentSermons();
      return Right(sermons);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Sermon>> getSermonById(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final sermon = await _remoteDataSource.getSermonById(id);
      return Right(sermon);
    } on NotFoundException {
      return const Left(NotFoundFailure(message: 'Номлол олдсонгүй'));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Sermon>> toggleSermonFavorite(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final sermon = await _remoteDataSource.toggleSermonFavorite(id);
      return Right(sermon);
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure(
        message: 'Дуртай номлолд нэмэхийн тулд нэвтрэх шаардлагатай',
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Sermon>>> searchSermons(String query) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final sermons = await _remoteDataSource.getSermons();
      final filteredSermons = sermons
          .where((sermon) =>
              sermon.title.toLowerCase().contains(query.toLowerCase()) ||
              sermon.preacher.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Right(filteredSermons);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
