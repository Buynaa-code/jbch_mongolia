import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/event.dart';

/// Abstract repository interface for events operations
abstract class EventsRepository {
  /// Get all events
  Future<Either<Failure, List<Event>>> getEvents();

  /// Get upcoming events
  Future<Either<Failure, List<Event>>> getUpcomingEvents();

  /// Get past events
  Future<Either<Failure, List<Event>>> getPastEvents();

  /// Get event by id
  Future<Either<Failure, Event>> getEventById(String id);

  /// Register for an event
  Future<Either<Failure, void>> registerForEvent(String eventId);

  /// Unregister from an event
  Future<Either<Failure, void>> unregisterFromEvent(String eventId);
}
