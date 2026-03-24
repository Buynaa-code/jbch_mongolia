import '../../domain/entities/sermon.dart';

/// Sermon model with JSON serialization
class SermonModel extends Sermon {
  const SermonModel({
    required super.id,
    required super.title,
    required super.preacher,
    required super.date,
    required super.duration,
    super.audioUrl,
    super.videoUrl,
    super.thumbnailUrl,
    super.description,
    super.bibleReference,
    super.isFavorite,
    super.series,
  });

  factory SermonModel.fromJson(Map<String, dynamic> json) {
    return SermonModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      preacher: json['preacher'] as String? ?? '',
      date: json['date'] != null
          ? DateTime.tryParse(json['date'] as String) ?? DateTime.now()
          : DateTime.now(),
      duration: Duration(milliseconds: json['durationMs'] as int? ?? 0),
      audioUrl: json['audioUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      description: json['description'] as String?,
      bibleReference: json['bibleReference'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      series: json['series'] != null
          ? SermonSeriesModel.fromJson(json['series'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'preacher': preacher,
        'date': date.toIso8601String(),
        'durationMs': duration.inMilliseconds,
        'audioUrl': audioUrl,
        'videoUrl': videoUrl,
        'thumbnailUrl': thumbnailUrl,
        'description': description,
        'bibleReference': bibleReference,
        'isFavorite': isFavorite,
        'series': series != null
            ? SermonSeriesModel(
                id: series!.id,
                name: series!.name,
                description: series!.description,
                imageUrl: series!.imageUrl,
              ).toJson()
            : null,
      };

  factory SermonModel.fromEntity(Sermon sermon) {
    return SermonModel(
      id: sermon.id,
      title: sermon.title,
      preacher: sermon.preacher,
      date: sermon.date,
      duration: sermon.duration,
      audioUrl: sermon.audioUrl,
      videoUrl: sermon.videoUrl,
      thumbnailUrl: sermon.thumbnailUrl,
      description: sermon.description,
      bibleReference: sermon.bibleReference,
      isFavorite: sermon.isFavorite,
      series: sermon.series,
    );
  }
}

/// Sermon series model with JSON serialization
class SermonSeriesModel extends SermonSeries {
  const SermonSeriesModel({
    required super.id,
    required super.name,
    super.description,
    super.imageUrl,
  });

  factory SermonSeriesModel.fromJson(Map<String, dynamic> json) {
    return SermonSeriesModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      };
}
