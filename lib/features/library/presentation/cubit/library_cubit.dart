import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/models/song_model.dart';
import '../../data/mock_library_data.dart';
import 'library_state.dart';

/// Cubit for managing Library feature state
class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(const LibraryInitial());

  /// Load library data
  Future<void> loadLibrary() async {
    emit(const LibraryLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      emit(LibraryLoaded(
        verses: MockLibraryData.verses,
        songs: MockLibraryData.songs,
        sermons: MockLibraryData.sermons,
      ));
    } catch (e) {
      emit(LibraryError('Номын сан ачаалахад алдаа гарлаа: $e'));
    }
  }

  /// Change current tab
  void changeTab(LibraryTab tab) {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      emit(currentState.copyWith(currentTab: tab));
    }
  }

  /// Update search query
  void search(String query) {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      emit(currentState.copyWith(searchQuery: query));
    }
  }

  /// Play a song
  void playSong(SongModel song) {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      emit(currentState.copyWith(
        currentlyPlayingSong: song,
        isPlaying: true,
        currentPosition: Duration.zero,
      ));
    }
  }

  /// Toggle play/pause
  void togglePlayPause() {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      emit(currentState.copyWith(isPlaying: !currentState.isPlaying));
    }
  }

  /// Update playback position
  void updatePosition(Duration position) {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      emit(currentState.copyWith(currentPosition: position));
    }
  }

  /// Toggle favorite for verse
  void toggleVerseFavorite(String verseId) {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      final updatedVerses = currentState.verses.map((v) {
        if (v.id == verseId) {
          return v.copyWith(isFavorite: !v.isFavorite);
        }
        return v;
      }).toList();
      emit(currentState.copyWith(verses: updatedVerses));
    }
  }

  /// Toggle favorite for song
  void toggleSongFavorite(String songId) {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      final updatedSongs = currentState.songs.map((s) {
        if (s.id == songId) {
          return s.copyWith(isFavorite: !s.isFavorite);
        }
        return s;
      }).toList();
      emit(currentState.copyWith(songs: updatedSongs));
    }
  }

  /// Toggle favorite for sermon
  void toggleSermonFavorite(String sermonId) {
    final currentState = state;
    if (currentState is LibraryLoaded) {
      final updatedSermons = currentState.sermons.map((s) {
        if (s.id == sermonId) {
          return s.copyWith(isFavorite: !s.isFavorite);
        }
        return s;
      }).toList();
      emit(currentState.copyWith(sermons: updatedSermons));
    }
  }

  /// Refresh library data
  Future<void> refresh() async {
    await loadLibrary();
  }
}
