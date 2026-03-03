import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/events_repository.dart';
import '../datasources/events_remote_data_source.dart';

@LazySingleton(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  final EventsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  EventsRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final events = await _remoteDataSource.getEvents();
      return Right(events);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getUpcomingEvents() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final events = await _remoteDataSource.getUpcomingEvents();
      return Right(events);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getPastEvents() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final events = await _remoteDataSource.getPastEvents();
      return Right(events);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> getEventById(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final event = await _remoteDataSource.getEventById(id);
      return Right(event);
    } on NotFoundException {
      return const Left(NotFoundFailure(
        message: 'Арга хэмжээ олдсонгүй',
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerForEvent(String eventId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      await _remoteDataSource.registerForEvent(eventId);
      return const Right(null);
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure(
        message: 'Бүртгүүлэхийн тулд нэвтрэх шаардлагатай',
      ));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unregisterFromEvent(String eventId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      await _remoteDataSource.unregisterFromEvent(eventId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
