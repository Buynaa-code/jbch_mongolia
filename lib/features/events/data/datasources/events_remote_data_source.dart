import 'package:injectable/injectable.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/event_model.dart';

/// Remote data source for events API calls
abstract class EventsRemoteDataSource {
  /// Get all events
  Future<List<EventModel>> getEvents();

  /// Get upcoming events
  Future<List<EventModel>> getUpcomingEvents();

  /// Get past events
  Future<List<EventModel>> getPastEvents();

  /// Get event by id
  Future<EventModel> getEventById(String id);

  /// Register for an event
  Future<void> registerForEvent(String eventId);

  /// Unregister from an event
  Future<void> unregisterFromEvent(String eventId);
}

@LazySingleton(as: EventsRemoteDataSource)
class EventsRemoteDataSourceImpl implements EventsRemoteDataSource {
  final DioClient _dioClient;

  EventsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<EventModel>> getEvents() async {
    final response = await _dioClient.get(ApiConstants.events);
    final data = response.data as Map<String, dynamic>;
    final eventsList = data['events'] as List<dynamic>;
    return eventsList
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<EventModel>> getUpcomingEvents() async {
    final response = await _dioClient.get(ApiConstants.upcomingEvents);
    final data = response.data as Map<String, dynamic>;
    final eventsList = data['events'] as List<dynamic>;
    return eventsList
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<EventModel>> getPastEvents() async {
    final response = await _dioClient.get(
      ApiConstants.events,
      queryParameters: {'status': 'past'},
    );
    final data = response.data as Map<String, dynamic>;
    final eventsList = data['events'] as List<dynamic>;
    return eventsList
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<EventModel> getEventById(String id) async {
    final response = await _dioClient.get(ApiConstants.eventById(id));
    final data = response.data as Map<String, dynamic>;
    return EventModel.fromJson(data['event'] as Map<String, dynamic>);
  }

  @override
  Future<void> registerForEvent(String eventId) async {
    await _dioClient.post(ApiConstants.registerForEvent(eventId));
  }

  @override
  Future<void> unregisterFromEvent(String eventId) async {
    await _dioClient.delete(ApiConstants.registerForEvent(eventId));
  }
}
