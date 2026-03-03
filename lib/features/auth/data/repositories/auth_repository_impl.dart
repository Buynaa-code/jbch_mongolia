import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/network/token_storage.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
    this._tokenStorage,
  );

  @override
  Future<Either<Failure, (User, AuthTokens)>> login({
    required String email,
    required String password,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final request = LoginRequest(email: email, password: password);
      final result = await _remoteDataSource.login(request);
      return Right(result);
    } on UnauthorizedException {
      return const Left(InvalidCredentialsFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, (User, AuthTokens)>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final request = RegisterRequest(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      final result = await _remoteDataSource.register(request);
      return Right(result);
    } on BadRequestException catch (e) {
      if (e.message.contains('email')) {
        return const Left(EmailAlreadyExistsFailure());
      }
      return Left(ValidationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      // Even if logout fails on server, we clear local tokens
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final user = await _remoteDataSource.getCurrentUser();
      return Right(user);
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _tokenStorage.hasTokens();
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshToken() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final tokens = await _remoteDataSource.refreshToken();
      return Right(tokens);
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
