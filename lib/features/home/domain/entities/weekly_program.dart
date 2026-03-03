import 'package:equatable/equatable.dart';

/// Represents a day in the weekly program
class WeeklyProgramItem extends Equatable {
  final String dayName;
  final List<WeeklyEvent> events;

  const WeeklyProgramItem({
    required this.dayName,
    required this.events,
  });

  @override
  List<Object?> get props => [dayName, events];
}

/// Represents an event in the weekly program
class WeeklyEvent extends Equatable {
  final String time;
  final String title;
  final String icon;

  const WeeklyEvent({
    required this.time,
    required this.title,
    required this.icon,
  });

  @override
  List<Object?> get props => [time, title, icon];
}
