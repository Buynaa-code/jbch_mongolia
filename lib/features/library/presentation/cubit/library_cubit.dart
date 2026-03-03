import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/sermon.dart';
import '../../domain/entities/song.dart';
import '../../domain/entities/verse.dart';
import '../../domain/usecases/get_sermons.dart';
import '../../domain/usecases/get_songs.dart';
import '../../domain/usecases/get_verses.dart';
import '../../domain/usecases/toggle_favorite.dart';
import 'library_state.dart';

/// Cubit for managing Library feature state
@injectable
class LibraryCubit extends Cubit<LibraryState> {
  final GetSongsUseCase _getSongsUseCase;
  final GetVersesUseCase _getVersesUseCase;
  final GetSermonsUseCase _getSermonsUseCase;
  final ToggleSongFavoriteUseCase _toggleSongFavoriteUseCase;
  final ToggleVerseFavoriteUseCase _toggleVerseFavoriteUseCase;
  final ToggleSermonFavoriteUseCase _toggleSermonFavoriteUseCase;

  LibraryCubit(
    this._getSongsUseCase,
    this._getVersesUseCase,
    this._getSermonsUseCase,
    this._toggleSongFavoriteUseCase,
    this._toggleVerseFavoriteUseCase,
    this._toggleSermonFavoriteUseCase,
  ) : super(const LibraryInitial());

  /// Load library data
  Future<void> loadLibrary() async {
    emit(const LibraryLoading());

    try {
      // Load all data separately to maintain type safety
      final versesResult = await _getVersesUseCase();
      final songsResult = await _getSongsUseCase();
      final sermonsResult = await _getSermonsUseCase();

      // Check for failures
      String? errorMessage;
      versesResult.fold(
        (failure) => errorMessage = failure.message,
        (_) {},
      );
      if (errorMessage != null) {
        emit(LibraryError(errorMessage!));
        return;
      }

      songsResult.fold(
        (failure) => errorMessage = failure.message,
        (_) {},
      );
      if (errorMessage != null) {
        emit(LibraryError(errorMessage!));
        return;
      }

      sermonsResult.fold(
        (failure) => errorMessage = failure.message,
        (_) {},
      );
      if (errorMessage != null) {
        emit(LibraryError(errorMessage!));
        return;
      }

      // Get the data with proper types
      final List<Verse> verses = versesResult.fold(
        (_) => <Verse>[],
        (data) => data,
      );
      final List<Song> songs = songsResult.fold(
        (_) => <Song>[],
        (data) => data,
      );
      final List<Sermon> sermons = sermonsResult.fold(
        (_) => <Sermon>[],
        (data) => data,
      );

      emit(LibraryLoaded(
        verses: verses,
        songs: songs,
        sermons: sermons,
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
  void playSong(Song song) {
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
  Future<void> toggleVerseFavorite(String verseId) async {
    final currentState = state;
    if (currentState is! LibraryLoaded) return;

    final result = await _toggleVerseFavoriteUseCase(verseId);

    result.fold(
      (failure) {
        // Show error but don't change state
      },
      (updatedVerse) {
        final updatedVerses = currentState.verses.map((v) {
          if (v.id == verseId) {
            return updatedVerse;
          }
          return v;
        }).toList();
        emit(currentState.copyWith(verses: updatedVerses));
      },
    );
  }

  /// Toggle favorite for song
  Future<void> toggleSongFavorite(String songId) async {
    final currentState = state;
    if (currentState is! LibraryLoaded) return;

    final result = await _toggleSongFavoriteUseCase(songId);

    result.fold(
      (failure) {
        // Show error but don't change state
      },
      (updatedSong) {
        final updatedSongs = currentState.songs.map((s) {
          if (s.id == songId) {
            return updatedSong;
          }
          return s;
        }).toList();
        emit(currentState.copyWith(songs: updatedSongs));
      },
    );
  }

  /// Toggle favorite for sermon
  Future<void> toggleSermonFavorite(String sermonId) async {
    final currentState = state;
    if (currentState is! LibraryLoaded) return;

    final result = await _toggleSermonFavoriteUseCase(sermonId);

    result.fold(
      (failure) {
        // Show error but don't change state
      },
      (updatedSermon) {
        final updatedSermons = currentState.sermons.map((s) {
          if (s.id == sermonId) {
            return updatedSermon;
          }
          return s;
        }).toList();
        emit(currentState.copyWith(sermons: updatedSermons));
      },
    );
  }

  /// Refresh library data
  Future<void> refresh() async {
    await loadLibrary();
  }
}
