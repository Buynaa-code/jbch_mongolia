import 'package:equatable/equatable.dart';

import '../../../../shared/models/event_model.dart';
import '../../../../shared/models/song_model.dart';
import '../../../../shared/models/verse_model.dart';
import '../../data/mock_home_data.dart';

/// State for the Home feature
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state before data is loaded
final class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Loading state while fetching data
final class HomeLoading extends HomeState {
  const HomeLoading();
}

/// Loaded state with all home data
final class HomeLoaded extends HomeState {
  final EventModel? nextSeminar;
  final List<WeeklyProgramItem> weeklyProgram;
  final VerseModel memoryVerse;
  final SongModel? currentSong;
  final List<SongModel> recentSongs;
  final bool isPlaying;
  final Duration currentPosition;

  const HomeLoaded({
    this.nextSeminar,
    required this.weeklyProgram,
    required this.memoryVerse,
    this.currentSong,
    required this.recentSongs,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
  });

  HomeLoaded copyWith({
    EventModel? nextSeminar,
    List<WeeklyProgramItem>? weeklyProgram,
    VerseModel? memoryVerse,
    SongModel? currentSong,
    List<SongModel>? recentSongs,
    bool? isPlaying,
    Duration? currentPosition,
  }) {
    return HomeLoaded(
      nextSeminar: nextSeminar ?? this.nextSeminar,
      weeklyProgram: weeklyProgram ?? this.weeklyProgram,
      memoryVerse: memoryVerse ?? this.memoryVerse,
      currentSong: currentSong ?? this.currentSong,
      recentSongs: recentSongs ?? this.recentSongs,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  @override
  List<Object?> get props => [
        nextSeminar,
        weeklyProgram,
        memoryVerse,
        currentSong,
        recentSongs,
        isPlaying,
        currentPosition,
      ];
}

/// Error state when something goes wrong
final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
