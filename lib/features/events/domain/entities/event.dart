import 'package:equatable/equatable.dart';

/// Event entity representing a church event
class Event extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String? imageUrl;
  final EventType type;
  final bool isUpcoming;
  final bool isRegistered;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    this.imageUrl,
    required this.type,
    this.isUpcoming = true,
    this.isRegistered = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dateTime,
        location,
        imageUrl,
        type,
        isUpcoming,
        isRegistered,
      ];
}

/// Types of church events
enum EventType {
  seminar,
  youthGroup,
  bibleStudy,
  prayer,
  fellowship,
  special,
}

extension EventTypeExtension on EventType {
  String get displayName {
    switch (this) {
      case EventType.seminar:
        return 'Семинар';
      case EventType.youthGroup:
        return 'Залуучууд';
      case EventType.bibleStudy:
        return 'Библи судлал';
      case EventType.prayer:
        return 'Залбирал';
      case EventType.fellowship:
        return 'Нөхөрлөл';
      case EventType.special:
        return 'Онцгой арга хэмжээ';
    }
  }

  String get emoji {
    switch (this) {
      case EventType.seminar:
        return '📚';
      case EventType.youthGroup:
        return '👥';
      case EventType.bibleStudy:
        return '📖';
      case EventType.prayer:
        return '🙏';
      case EventType.fellowship:
        return '🤝';
      case EventType.special:
        return '⭐';
    }
  }

  static EventType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'seminar':
        return EventType.seminar;
      case 'youthgroup':
      case 'youth_group':
        return EventType.youthGroup;
      case 'biblestudy':
      case 'bible_study':
        return EventType.bibleStudy;
      case 'prayer':
        return EventType.prayer;
      case 'fellowship':
        return EventType.fellowship;
      case 'special':
      default:
        return EventType.special;
    }
  }
}
