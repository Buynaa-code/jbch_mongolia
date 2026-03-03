import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/events_repository.dart';

/// Use case for registering for an event
@lazySingleton
class RegisterForEventUseCase {
  final EventsRepository _repository;

  RegisterForEventUseCase(this._repository);

  Future<Either<Failure, void>> call(String eventId) {
    return _repository.registerForEvent(eventId);
  }
}
