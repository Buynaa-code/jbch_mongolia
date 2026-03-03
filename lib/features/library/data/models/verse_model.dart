import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/verse.dart';

part 'verse_model.g.dart';

/// Verse model with JSON serialization
@JsonSerializable()
class VerseModel extends Verse {
  const VerseModel({
    required super.id,
    required super.book,
    required super.chapter,
    required super.verseStart,
    super.verseEnd,
    required super.text,
    super.isFavorite,
    super.isMemoryVerse,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) =>
      _$VerseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerseModelToJson(this);

  factory VerseModel.fromEntity(Verse verse) {
    return VerseModel(
      id: verse.id,
      book: verse.book,
      chapter: verse.chapter,
      verseStart: verse.verseStart,
      verseEnd: verse.verseEnd,
      text: verse.text,
      isFavorite: verse.isFavorite,
      isMemoryVerse: verse.isMemoryVerse,
    );
  }
}
