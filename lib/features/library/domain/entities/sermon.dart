import 'package:equatable/equatable.dart';

/// Sermon entity representing a sermon recording
class Sermon extends Equatable {
  final String id;
  final String title;
  final String preacher;
  final DateTime date;
  final Duration duration;
  final String? audioUrl;
  final String? videoUrl;
  final String? thumbnailUrl;
  final String? description;
  final String? bibleReference;
  final bool isFavorite;
  final SermonSeries? series;

  const Sermon({
    required this.id,
    required this.title,
    required this.preacher,
    required this.date,
    required this.duration,
    this.audioUrl,
    this.videoUrl,
    this.thumbnailUrl,
    this.description,
    this.bibleReference,
    this.isFavorite = false,
    this.series,
  });

  /// Returns formatted duration string (e.g., "45:30" or "1:15:30")
  String get formattedDuration {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  /// Returns formatted date string
  String get formattedDate {
    final months = [
      'нэгдүгээр сар',
      'хоёрдугаар сар',
      'гуравдугаар сар',
      'дөрөвдүгээр сар',
      'тавдугаар сар',
      'зургадугаар сар',
      'долдугаар сар',
      'наймдугаар сар',
      'есдүгээр сар',
      'аравдугаар сар',
      'арван нэгдүгээр сар',
      'арван хоёрдугаар сар',
    ];
    return '${date.year} оны ${months[date.month - 1]}ын ${date.day}';
  }

  /// Returns true if the sermon has a valid audio or video URL to play
  bool get isPlayable =>
      (audioUrl != null && audioUrl!.isNotEmpty) ||
      (videoUrl != null && videoUrl!.isNotEmpty);

  Sermon copyWith({
    String? id,
    String? title,
    String? preacher,
    DateTime? date,
    Duration? duration,
    String? audioUrl,
    String? videoUrl,
    String? thumbnailUrl,
    String? description,
    String? bibleReference,
    bool? isFavorite,
    SermonSeries? series,
  }) {
    return Sermon(
      id: id ?? this.id,
      title: title ?? this.title,
      preacher: preacher ?? this.preacher,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      audioUrl: audioUrl ?? this.audioUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      description: description ?? this.description,
      bibleReference: bibleReference ?? this.bibleReference,
      isFavorite: isFavorite ?? this.isFavorite,
      series: series ?? this.series,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        preacher,
        date,
        duration,
        audioUrl,
        videoUrl,
        thumbnailUrl,
        description,
        bibleReference,
        isFavorite,
        series,
      ];
}

/// Represents a sermon series
class SermonSeries extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;

  const SermonSeries({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl];
}
