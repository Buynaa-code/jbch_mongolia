import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/song.dart';

part 'song_model.g.dart';

/// Song model with JSON serialization
@JsonSerializable(createFactory: false)
class SongModel extends Song {
  const SongModel({
    required super.id,
    required super.title,
    required super.artist,
    super.albumArt,
    required super.duration,
    super.audioUrl,
    super.lyrics,
    super.isFavorite,
    required super.category,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      artist: json['artist'] as String? ?? '',
      albumArt: json['albumArt'] as String?,
      duration: Duration(milliseconds: json['durationMs'] as int? ?? 0),
      audioUrl: json['audioUrl'] as String?,
      lyrics: json['lyrics'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      category: _parseSongCategory(json['category']),
    );
  }

  static SongCategory _parseSongCategory(dynamic value) {
    if (value == null) return SongCategory.praise;
    if (value is String) {
      return SongCategory.values.firstWhere(
        (e) => e.name == value,
        orElse: () => SongCategory.praise,
      );
    }
    return SongCategory.praise;
  }

  Map<String, dynamic> toJson() => _$SongModelToJson(this);

  factory SongModel.fromEntity(Song song) {
    return SongModel(
      id: song.id,
      title: song.title,
      artist: song.artist,
      albumArt: song.albumArt,
      duration: song.duration,
      audioUrl: song.audioUrl,
      lyrics: song.lyrics,
      isFavorite: song.isFavorite,
      category: song.category,
    );
  }
}
