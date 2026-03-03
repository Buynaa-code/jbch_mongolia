// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyProgramItemModel _$WeeklyProgramItemModelFromJson(
        Map<String, dynamic> json) =>
    WeeklyProgramItemModel(
      dayName: json['dayName'] as String,
      events: (json['events'] as List<dynamic>)
          .map((e) => WeeklyEventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeeklyProgramItemModelToJson(
        WeeklyProgramItemModel instance) =>
    <String, dynamic>{
      'dayName': instance.dayName,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };

WeeklyEventModel _$WeeklyEventModelFromJson(Map<String, dynamic> json) =>
    WeeklyEventModel(
      time: json['time'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeeklyEventModelToJson(WeeklyEventModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'title': instance.title,
      'icon': instance.icon,
    };
