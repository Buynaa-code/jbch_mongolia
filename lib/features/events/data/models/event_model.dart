import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/event.dart';

part 'event_model.g.dart';

/// Event model with JSON serialization
@JsonSerializable()
class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dateTime,
    required super.location,
    super.imageUrl,
    required super.type,
    super.isUpcoming,
    super.isRegistered,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      dateTime: json['dateTime'] != null
          ? DateTime.tryParse(json['dateTime'] as String) ?? DateTime.now()
          : DateTime.now(),
      location: json['location'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      type: _parseEventType(json['type']),
      isUpcoming: json['isUpcoming'] as bool? ?? true,
      isRegistered: json['isRegistered'] as bool? ?? false,
    );
  }

  static EventType _parseEventType(dynamic value) {
    if (value == null) return EventType.special;
    if (value is String) {
      return EventTypeExtension.fromString(value);
    }
    return EventType.special;
  }

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  factory EventModel.fromEntity(Event event) {
    return EventModel(
      id: event.id,
      title: event.title,
      description: event.description,
      dateTime: event.dateTime,
      location: event.location,
      imageUrl: event.imageUrl,
      type: event.type,
      isUpcoming: event.isUpcoming,
      isRegistered: event.isRegistered,
    );
  }
}
