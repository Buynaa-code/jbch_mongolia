import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/event.dart';
import '../repositories/events_repository.dart';

/// Use case for getting upcoming events
@lazySingleton
class GetUpcomingEventsUseCase {
  final EventsRepository _repository;

  GetUpcomingEventsUseCase(this._repository);

  Future<Either<Failure, List<Event>>> call() {
    return _repository.getUpcomingEvents();
  }
}
