import '../../domain/entities/weekly_program.dart';

/// Weekly program item model with JSON serialization
class WeeklyProgramItemModel extends WeeklyProgramItem {
  const WeeklyProgramItemModel({
    required super.dayName,
    required List<WeeklyEventModel> events,
  }) : super(events: events);

  /// Typed getter for events as WeeklyEventModel list
  List<WeeklyEventModel> get typedEvents =>
      events.cast<WeeklyEventModel>().toList();

  factory WeeklyProgramItemModel.fromJson(Map<String, dynamic> json) {
    final eventsList = json['events'] as List<dynamic>? ?? [];
    return WeeklyProgramItemModel(
      dayName: json['dayName'] as String? ?? '',
      events: eventsList
          .map((e) => WeeklyEventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'dayName': dayName,
        'events': typedEvents.map((e) => e.toJson()).toList(),
      };
}

/// Weekly event model with JSON serialization
class WeeklyEventModel extends WeeklyEvent {
  const WeeklyEventModel({
    required super.time,
    required super.title,
    required super.icon,
  });

  factory WeeklyEventModel.fromJson(Map<String, dynamic> json) {
    return WeeklyEventModel(
      time: json['time'] as String? ?? '',
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String? ?? 'event',
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'title': title,
        'icon': icon,
      };
}
