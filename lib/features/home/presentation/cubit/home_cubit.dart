import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/models/song_model.dart';
import '../../data/mock_home_data.dart';
import 'home_state.dart';

/// Cubit for managing Home feature state
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  /// Load home data
  Future<void> loadHomeData() async {
    emit(const HomeLoading());

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      emit(HomeLoaded(
        nextSeminar: MockHomeData.nextSeminar,
        weeklyProgram: MockHomeData.weeklyProgram,
        memoryVerse: MockHomeData.memoryVerse,
        currentSong: MockHomeData.quickPlaySong,
        recentSongs: MockHomeData.recentSongs,
      ));
    } catch (e) {
      emit(HomeError('Өгөгдөл ачаалахад алдаа гарлаа: $e'));
    }
  }

  /// Toggle play/pause for the current song
  void togglePlayPause() {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(isPlaying: !currentState.isPlaying));
    }
  }

  /// Set the current song
  void setCurrentSong(SongModel song) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(
        currentSong: song,
        isPlaying: true,
        currentPosition: Duration.zero,
      ));
    }
  }

  /// Update playback position
  void updatePosition(Duration position) {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(currentState.copyWith(currentPosition: position));
    }
  }

  /// Refresh home data
  Future<void> refresh() async {
    await loadHomeData();
  }
}
