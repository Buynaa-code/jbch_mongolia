// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'stringify': instance.stringify,
      'hashCode': instance.hashCode,
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'type': _$EventTypeEnumMap[instance.type]!,
      'isUpcoming': instance.isUpcoming,
      'isRegistered': instance.isRegistered,
      'props': instance.props,
    };

const _$EventTypeEnumMap = {
  EventType.seminar: 'seminar',
  EventType.youthGroup: 'youthGroup',
  EventType.bibleStudy: 'bibleStudy',
  EventType.prayer: 'prayer',
  EventType.fellowship: 'fellowship',
  EventType.special: 'special',
};
