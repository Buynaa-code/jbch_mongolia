// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SongModelToJson(SongModel instance) => <String, dynamic>{
  'stringify': instance.stringify,
  'hashCode': instance.hashCode,
  'id': instance.id,
  'title': instance.title,
  'artist': instance.artist,
  'albumArt': instance.albumArt,
  'duration': instance.duration.inMicroseconds,
  'audioUrl': instance.audioUrl,
  'lyrics': instance.lyrics,
  'isFavorite': instance.isFavorite,
  'category': _$SongCategoryEnumMap[instance.category]!,
  'formattedDuration': instance.formattedDuration,
  'isPlayable': instance.isPlayable,
  'props': instance.props,
};

const _$SongCategoryEnumMap = {
  SongCategory.praise: 'praise',
  SongCategory.hymn: 'hymn',
  SongCategory.contemporary: 'contemporary',
  SongCategory.children: 'children',
};
