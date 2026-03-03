import 'package:equatable/equatable.dart';

import '../../domain/entities/sermon.dart';
import '../../domain/entities/song.dart';
import '../../domain/entities/verse.dart';

/// Enum for library tabs
enum LibraryTab { verses, songs, sermons }

/// State for the Library feature
sealed class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

/// Initial state before data is loaded
final class LibraryInitial extends LibraryState {
  const LibraryInitial();
}

/// Loading state while fetching data
final class LibraryLoading extends LibraryState {
  const LibraryLoading();
}

/// Loaded state with library data
final class LibraryLoaded extends LibraryState {
  final List<Verse> verses;
  final List<Song> songs;
  final List<Sermon> sermons;
  final LibraryTab currentTab;
  final Song? currentlyPlayingSong;
  final bool isPlaying;
  final Duration currentPosition;
  final String searchQuery;

  const LibraryLoaded({
    required this.verses,
    required this.songs,
    required this.sermons,
    this.currentTab = LibraryTab.verses,
    this.currentlyPlayingSong,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
    this.searchQuery = '',
  });

  List<Verse> get filteredVerses {
    if (searchQuery.isEmpty) return verses;
    final query = searchQuery.toLowerCase();
    return verses
        .where((v) =>
            v.text.toLowerCase().contains(query) ||
            v.reference.toLowerCase().contains(query))
        .toList();
  }

  List<Song> get filteredSongs {
    if (searchQuery.isEmpty) return songs;
    final query = searchQuery.toLowerCase();
    return songs
        .where((s) =>
            s.title.toLowerCase().contains(query) ||
            s.artist.toLowerCase().contains(query))
        .toList();
  }

  List<Sermon> get filteredSermons {
    if (searchQuery.isEmpty) return sermons;
    final query = searchQuery.toLowerCase();
    return sermons
        .where((s) =>
            s.title.toLowerCase().contains(query) ||
            s.preacher.toLowerCase().contains(query) ||
            (s.bibleReference?.toLowerCase().contains(query) ?? false))
        .toList();
  }

  List<Verse> get favoriteVerses =>
      verses.where((v) => v.isFavorite).toList();

  List<Song> get favoriteSongs => songs.where((s) => s.isFavorite).toList();

  List<Sermon> get favoriteSermons =>
      sermons.where((s) => s.isFavorite).toList();

  LibraryLoaded copyWith({
    List<Verse>? verses,
    List<Song>? songs,
    List<Sermon>? sermons,
    LibraryTab? currentTab,
    Song? currentlyPlayingSong,
    bool? isPlaying,
    Duration? currentPosition,
    String? searchQuery,
  }) {
    return LibraryLoaded(
      verses: verses ?? this.verses,
      songs: songs ?? this.songs,
      sermons: sermons ?? this.sermons,
      currentTab: currentTab ?? this.currentTab,
      currentlyPlayingSong: currentlyPlayingSong ?? this.currentlyPlayingSong,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        verses,
        songs,
        sermons,
        currentTab,
        currentlyPlayingSong,
        isPlaying,
        currentPosition,
        searchQuery,
      ];
}

/// Error state when something goes wrong
final class LibraryError extends LibraryState {
  final String message;

  const LibraryError(this.message);

  @override
  List<Object?> get props => [message];
}
