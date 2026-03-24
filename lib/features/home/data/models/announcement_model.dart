import '../../domain/entities/announcement.dart';

/// Data model for Announcement with JSON serialization
class AnnouncementModel extends Announcement {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.description,
    super.imageUrl,
    super.priority,
    super.expiresAt,
    super.actionUrl,
    super.actionLabel,
    required super.createdAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      priority: _priorityFromString(json['priority'] as String?),
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
      actionUrl: json['actionUrl'] as String?,
      actionLabel: json['actionLabel'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'priority': priority.name,
      'expiresAt': expiresAt?.toIso8601String(),
      'actionUrl': actionUrl,
      'actionLabel': actionLabel,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static AnnouncementPriority _priorityFromString(String? value) {
    switch (value) {
      case 'important':
        return AnnouncementPriority.important;
      case 'urgent':
        return AnnouncementPriority.urgent;
      default:
        return AnnouncementPriority.normal;
    }
  }

  factory AnnouncementModel.fromEntity(Announcement entity) {
    return AnnouncementModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      priority: entity.priority,
      expiresAt: entity.expiresAt,
      actionUrl: entity.actionUrl,
      actionLabel: entity.actionLabel,
      createdAt: entity.createdAt,
    );
  }
}
