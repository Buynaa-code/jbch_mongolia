import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/sermon.dart';

part 'sermon_model.g.dart';

/// Sermon model with JSON serialization
@JsonSerializable()
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

  factory SermonModel.fromJson(Map<String, dynamic> json) =>
      _$SermonModelFromJson(json);

  Map<String, dynamic> toJson() => _$SermonModelToJson(this);

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
@JsonSerializable()
class SermonSeriesModel extends SermonSeries {
  const SermonSeriesModel({
    required super.id,
    required super.name,
    super.description,
    super.imageUrl,
  });

  factory SermonSeriesModel.fromJson(Map<String, dynamic> json) =>
      _$SermonSeriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$SermonSeriesModelToJson(this);
}
