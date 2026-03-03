import 'package:equatable/equatable.dart';

/// Verse entity representing a Bible verse
class Verse extends Equatable {
  final String id;
  final String book;
  final int chapter;
  final int verseStart;
  final int? verseEnd;
  final String text;
  final bool isFavorite;
  final bool isMemoryVerse;

  const Verse({
    required this.id,
    required this.book,
    required this.chapter,
    required this.verseStart,
    this.verseEnd,
    required this.text,
    this.isFavorite = false,
    this.isMemoryVerse = false,
  });

  /// Returns the verse reference string (e.g., "Иохан 3:16" or "Дуулал 23:1-6")
  String get reference {
    final verseRange =
        verseEnd != null ? '$verseStart-$verseEnd' : '$verseStart';
    return '$book $chapter:$verseRange';
  }

  Verse copyWith({
    String? id,
    String? book,
    int? chapter,
    int? verseStart,
    int? verseEnd,
    String? text,
    bool? isFavorite,
    bool? isMemoryVerse,
  }) {
    return Verse(
      id: id ?? this.id,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      verseStart: verseStart ?? this.verseStart,
      verseEnd: verseEnd ?? this.verseEnd,
      text: text ?? this.text,
      isFavorite: isFavorite ?? this.isFavorite,
      isMemoryVerse: isMemoryVerse ?? this.isMemoryVerse,
    );
  }

  @override
  List<Object?> get props => [
        id,
        book,
        chapter,
        verseStart,
        verseEnd,
        text,
        isFavorite,
        isMemoryVerse,
      ];
}
