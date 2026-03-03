// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongModel _$SongModelFromJson(Map<String, dynamic> json) => SongModel(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      albumArt: json['albumArt'] as String?,
      duration: Duration(milliseconds: json['durationMs'] as int? ?? 0),
      audioUrl: json['audioUrl'] as String?,
      lyrics: json['lyrics'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      category: $enumDecode(_$SongCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'albumArt': instance.albumArt,
      'durationMs': instance.duration.inMilliseconds,
      'audioUrl': instance.audioUrl,
      'lyrics': instance.lyrics,
      'isFavorite': instance.isFavorite,
      'category': _$SongCategoryEnumMap[instance.category]!,
    };

const _$SongCategoryEnumMap = {
  SongCategory.praise: 'praise',
  SongCategory.hymn: 'hymn',
  SongCategory.contemporary: 'contemporary',
  SongCategory.children: 'children',
};
