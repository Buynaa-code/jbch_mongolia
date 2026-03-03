// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseModel _$VerseModelFromJson(Map<String, dynamic> json) => VerseModel(
      id: json['id'] as String,
      book: json['book'] as String,
      chapter: (json['chapter'] as num).toInt(),
      verseStart: (json['verseStart'] as num).toInt(),
      verseEnd: (json['verseEnd'] as num?)?.toInt(),
      text: json['text'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isMemoryVerse: json['isMemoryVerse'] as bool? ?? false,
    );

Map<String, dynamic> _$VerseModelToJson(VerseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book': instance.book,
      'chapter': instance.chapter,
      'verseStart': instance.verseStart,
      'verseEnd': instance.verseEnd,
      'text': instance.text,
      'isFavorite': instance.isFavorite,
      'isMemoryVerse': instance.isMemoryVerse,
    };
