import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/network/token_storage.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../datasources/profile_remote_data_source.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final TokenStorage _tokenStorage;

  ProfileRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
    this._tokenStorage,
  );

  @override
  Future<Either<Failure, UserProfile>> getProfile() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final result = await _remoteDataSource.getProfile();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException {
      return const Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfile({
    String? name,
    String? email,
    String? profileImageUrl,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final result = await _remoteDataSource.updateProfile(
        name: name,
        email: email,
        profileImageUrl: profileImageUrl,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException {
      return const Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, List<Song>>> getFavoriteSongs() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final result = await _remoteDataSource.getFavoriteSongs();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException {
      return const Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, List<Verse>>> getFavoriteVerses() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final result = await _remoteDataSource.getFavoriteVerses();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException {
      return const Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, ThemeMode>> getThemeMode() async {
    try {
      final result = await _localDataSource.getThemeMode();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setThemeMode(ThemeMode mode) async {
    try {
      await _localDataSource.setThemeMode(mode);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getNotificationsEnabled() async {
    try {
      final result = await _localDataSource.getNotificationsEnabled();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setNotificationsEnabled(bool enabled) async {
    try {
      await _localDataSource.setNotificationsEnabled(enabled);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _tokenStorage.clearTokens();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
