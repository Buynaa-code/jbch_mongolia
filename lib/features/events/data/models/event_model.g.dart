// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String?,
      type: $enumDecode(_$EventTypeEnumMap, json['type']),
      isUpcoming: json['isUpcoming'] as bool? ?? true,
      isRegistered: json['isRegistered'] as bool? ?? false,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'type': _$EventTypeEnumMap[instance.type]!,
      'isUpcoming': instance.isUpcoming,
      'isRegistered': instance.isRegistered,
    };

const _$EventTypeEnumMap = {
  EventType.seminar: 'seminar',
  EventType.youthGroup: 'youthGroup',
  EventType.bibleStudy: 'bibleStudy',
  EventType.prayer: 'prayer',
  EventType.fellowship: 'fellowship',
  EventType.special: 'special',
};
