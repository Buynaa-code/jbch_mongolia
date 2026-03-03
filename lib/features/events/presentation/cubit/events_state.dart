import 'package:equatable/equatable.dart';

import '../../domain/entities/event.dart';

/// State for the Events feature
sealed class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

/// Initial state before data is loaded
final class EventsInitial extends EventsState {
  const EventsInitial();
}

/// Loading state while fetching data
final class EventsLoading extends EventsState {
  const EventsLoading();
}

/// Loaded state with events data
final class EventsLoaded extends EventsState {
  final List<Event> upcomingEvents;
  final List<Event> pastEvents;
  final EventType? selectedFilter;

  const EventsLoaded({
    required this.upcomingEvents,
    required this.pastEvents,
    this.selectedFilter,
  });

  List<Event> get filteredUpcomingEvents {
    if (selectedFilter == null) return upcomingEvents;
    return upcomingEvents.where((e) => e.type == selectedFilter).toList();
  }

  List<Event> get filteredPastEvents {
    if (selectedFilter == null) return pastEvents;
    return pastEvents.where((e) => e.type == selectedFilter).toList();
  }

  EventsLoaded copyWith({
    List<Event>? upcomingEvents,
    List<Event>? pastEvents,
    EventType? selectedFilter,
    bool clearFilter = false,
  }) {
    return EventsLoaded(
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      pastEvents: pastEvents ?? this.pastEvents,
      selectedFilter:
          clearFilter ? null : (selectedFilter ?? this.selectedFilter),
    );
  }

  @override
  List<Object?> get props => [upcomingEvents, pastEvents, selectedFilter];
}

/// Error state when something goes wrong
final class EventsError extends EventsState {
  final String message;

  const EventsError(this.message);

  @override
  List<Object?> get props => [message];
}
