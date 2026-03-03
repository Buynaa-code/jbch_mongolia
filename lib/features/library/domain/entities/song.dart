import 'package:equatable/equatable.dart';

/// Song entity representing a worship song
class Song extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String? albumArt;
  final Duration duration;
  final String? audioUrl;
  final String? lyrics;
  final bool isFavorite;
  final SongCategory category;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    this.albumArt,
    required this.duration,
    this.audioUrl,
    this.lyrics,
    this.isFavorite = false,
    required this.category,
  });

  /// Returns formatted duration string (e.g., "3:45")
  String get formattedDuration {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? albumArt,
    Duration? duration,
    String? audioUrl,
    String? lyrics,
    bool? isFavorite,
    SongCategory? category,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      albumArt: albumArt ?? this.albumArt,
      duration: duration ?? this.duration,
      audioUrl: audioUrl ?? this.audioUrl,
      lyrics: lyrics ?? this.lyrics,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        artist,
        albumArt,
        duration,
        audioUrl,
        lyrics,
        isFavorite,
        category,
      ];
}

/// Categories of songs
enum SongCategory {
  praise,
  hymn,
  contemporary,
  children,
}

extension SongCategoryExtension on SongCategory {
  String get displayName {
    switch (this) {
      case SongCategory.praise:
        return 'Магтаалын дуу';
      case SongCategory.hymn:
        return 'Сүмийн дуу';
      case SongCategory.contemporary:
        return 'Орчин үеийн';
      case SongCategory.children:
        return 'Хүүхдийн дуу';
    }
  }

  static SongCategory fromString(String value) {
    switch (value.toLowerCase()) {
      case 'praise':
        return SongCategory.praise;
      case 'hymn':
        return SongCategory.hymn;
      case 'contemporary':
        return SongCategory.contemporary;
      case 'children':
        return SongCategory.children;
      default:
        return SongCategory.praise;
    }
  }
}
