import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/models/event_model.dart';
import '../../data/mock_events_data.dart';
import 'events_state.dart';

/// Cubit for managing Events feature state
class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(const EventsInitial());

  /// Load events data
  Future<void> loadEvents() async {
    emit(const EventsLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      emit(EventsLoaded(
        upcomingEvents: MockEventsData.upcomingEvents,
        pastEvents: MockEventsData.pastEvents,
      ));
    } catch (e) {
      emit(EventsError('Арга хэмжээ ачаалахад алдаа гарлаа: $e'));
    }
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
