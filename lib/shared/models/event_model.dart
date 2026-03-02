import 'package:equatable/equatable.dart';

/// Represents a church event
class EventModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String? imageUrl;
  final EventType type;
  final bool isUpcoming;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    this.imageUrl,
    required this.type,
    this.isUpcoming = true,
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
      ];
}

/// Types of church events
enum EventType {
  seminar,
  worship,
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
      case EventType.worship:
        return 'Мөргөл';
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
      case EventType.worship:
        return '🙏';
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
}
