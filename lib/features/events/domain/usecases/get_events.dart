import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/event.dart';
import '../repositories/events_repository.dart';

/// Use case for getting all events
@lazySingleton
class GetEventsUseCase {
  final EventsRepository _repository;

  GetEventsUseCase(this._repository);

  Future<Either<Failure, List<Event>>> call() {
    return _repository.getEvents();
  }
}
