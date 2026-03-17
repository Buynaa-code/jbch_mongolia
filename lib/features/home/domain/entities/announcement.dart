import 'package:equatable/equatable.dart';

/// Priority levels for announcements
enum AnnouncementPriority { normal, important, urgent }

/// Entity representing a special announcement
class Announcement extends Equatable {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final AnnouncementPriority priority;
  final DateTime? expiresAt;
  final String? actionUrl;
  final String? actionLabel;
  final DateTime createdAt;

  const Announcement({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.priority = AnnouncementPriority.normal,
    this.expiresAt,
    this.actionUrl,
    this.actionLabel,
    required this.createdAt,
  });

  bool get isExpired {
    final expiry = expiresAt;
    return expiry != null && DateTime.now().isAfter(expiry);
  }

  bool get hasAction => actionUrl != null && actionLabel != null;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        priority,
        expiresAt,
        actionUrl,
        actionLabel,
        createdAt,
      ];
}
