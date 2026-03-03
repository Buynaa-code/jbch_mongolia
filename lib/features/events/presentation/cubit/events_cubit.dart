import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/event.dart';
import '../../domain/usecases/get_events.dart';
import '../../domain/usecases/get_upcoming_events.dart';
import '../../domain/usecases/register_for_event.dart';
import 'events_state.dart';

/// Cubit for managing Events feature state
@injectable
class EventsCubit extends Cubit<EventsState> {
  final GetEventsUseCase _getEventsUseCase;
  final GetUpcomingEventsUseCase _getUpcomingEventsUseCase;
  final RegisterForEventUseCase _registerForEventUseCase;

  EventsCubit(
    this._getEventsUseCase,
    this._getUpcomingEventsUseCase,
    this._registerForEventUseCase,
  ) : super(const EventsInitial());

  /// Load events data
  Future<void> loadEvents() async {
    emit(const EventsLoading());

    final result = await _getEventsUseCase();

    result.fold(
      (failure) => emit(EventsError(failure.message)),
      (events) {
        final now = DateTime.now();
        final upcomingEvents =
            events.where((e) => e.dateTime.isAfter(now)).toList();
        final pastEvents =
            events.where((e) => e.dateTime.isBefore(now)).toList();

        emit(EventsLoaded(
          upcomingEvents: upcomingEvents,
          pastEvents: pastEvents,
        ));
      },
    );
  }

  /// Load only upcoming events
  Future<void> loadUpcomingEvents() async {
    emit(const EventsLoading());

    final result = await _getUpcomingEventsUseCase();

    result.fold(
      (failure) => emit(EventsError(failure.message)),
      (events) => emit(EventsLoaded(
        upcomingEvents: events,
        pastEvents: const [],
      )),
    );
  }

  /// Register for an event
  Future<void> registerForEvent(String eventId) async {
    final currentState = state;
    if (currentState is! EventsLoaded) return;

    final result = await _registerForEventUseCase(eventId);

    result.fold(
      (failure) => emit(EventsError(failure.message)),
      (_) {
        // Update the event in the list to show as registered
        final updatedUpcoming = currentState.upcomingEvents.map((event) {
          if (event.id == eventId) {
            return Event(
              id: event.id,
              title: event.title,
              description: event.description,
              dateTime: event.dateTime,
              location: event.location,
              imageUrl: event.imageUrl,
              type: event.type,
              isUpcoming: event.isUpcoming,
              isRegistered: true,
            );
          }
          return event;
        }).toList();

        emit(currentState.copyWith(upcomingEvents: updatedUpcoming));
      },
    );
  }

  /// Filter events by type
  void filterByType(EventType? type) {
    final currentState = state;
    if (currentState is EventsLoaded) {
      if (type == currentState.selectedFilter) {
        // Toggle off if same filter is selected
        emit(currentState.copyWith(clearFilter: true));
      } else {
        emit(currentState.copyWith(selectedFilter: type));
      }
    }
  }

  /// Clear filter
  void clearFilter() {
    final currentState = state;
    if (currentState is EventsLoaded) {
      emit(currentState.copyWith(clearFilter: true));
    }
  }

  /// Refresh events data
  Future<void> refresh() async {
    await loadEvents();
  }
}
