import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class GetThemeModeUseCase {
  final ProfileRepository repository;

  GetThemeModeUseCase(this.repository);

  Future<Either<Failure, ThemeMode>> call() {
    return repository.getThemeMode();
  }
}

@lazySingleton
class SetThemeModeUseCase {
  final ProfileRepository repository;

  SetThemeModeUseCase(this.repository);

  Future<Either<Failure, void>> call(ThemeMode mode) {
    return repository.setThemeMode(mode);
  }
}

@lazySingleton
class GetNotificationsEnabledUseCase {
  final ProfileRepository repository;

  GetNotificationsEnabledUseCase(this.repository);

  Future<Either<Failure, bool>> call() {
    return repository.getNotificationsEnabled();
  }
}

@lazySingleton
class SetNotificationsEnabledUseCase {
  final ProfileRepository repository;

  SetNotificationsEnabledUseCase(this.repository);

  Future<Either<Failure, void>> call(bool enabled) {
    return repository.setNotificationsEnabled(enabled);
  }
}

@lazySingleton
class LogoutUseCase {
  final ProfileRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
