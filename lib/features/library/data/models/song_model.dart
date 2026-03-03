import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/song.dart';

part 'song_model.g.dart';

/// Song model with JSON serialization
@JsonSerializable()
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

  factory SongModel.fromJson(Map<String, dynamic> json) =>
      _$SongModelFromJson(json);

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
