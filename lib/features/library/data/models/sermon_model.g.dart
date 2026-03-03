// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sermon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SermonModel _$SermonModelFromJson(Map<String, dynamic> json) => SermonModel(
      id: json['id'] as String,
      title: json['title'] as String,
      preacher: json['preacher'] as String,
      date: DateTime.parse(json['date'] as String),
      duration: Duration(milliseconds: json['durationMs'] as int? ?? 0),
      audioUrl: json['audioUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      description: json['description'] as String?,
      bibleReference: json['bibleReference'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      series: json['series'] == null
          ? null
          : SermonSeriesModel.fromJson(json['series'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SermonModelToJson(SermonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'preacher': instance.preacher,
      'date': instance.date.toIso8601String(),
      'durationMs': instance.duration.inMilliseconds,
      'audioUrl': instance.audioUrl,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'bibleReference': instance.bibleReference,
      'isFavorite': instance.isFavorite,
      'series': instance.series,
    };

SermonSeriesModel _$SermonSeriesModelFromJson(Map<String, dynamic> json) =>
    SermonSeriesModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$SermonSeriesModelToJson(SermonSeriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
