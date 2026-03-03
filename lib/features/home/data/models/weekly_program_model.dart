import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/weekly_program.dart';

part 'weekly_program_model.g.dart';

/// Weekly program item model with JSON serialization
@JsonSerializable()
class WeeklyProgramItemModel extends WeeklyProgramItem {
  @override
  final List<WeeklyEventModel> events;

  const WeeklyProgramItemModel({
    required super.dayName,
    required this.events,
  }) : super(events: events);

  factory WeeklyProgramItemModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyProgramItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyProgramItemModelToJson(this);
}

/// Weekly event model with JSON serialization
@JsonSerializable()
class WeeklyEventModel extends WeeklyEvent {
  const WeeklyEventModel({
    required super.time,
    required super.title,
    required super.icon,
  });

  factory WeeklyEventModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyEventModelToJson(this);
}
