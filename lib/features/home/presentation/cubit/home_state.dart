import 'package:equatable/equatable.dart';

import '../../../events/domain/entities/event.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../../domain/entities/weekly_program.dart';

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
  final List<Event> seminars;
  final List<WeeklyProgramItem> weeklyProgram;
  final Verse? memoryVerse;
  final Song? currentSong;
  final List<Song> recentSongs;
  final bool isPlaying;
  final Duration currentPosition;

  const HomeLoaded({
    this.seminars = const [],
    required this.weeklyProgram,
    this.memoryVerse,
    this.currentSong,
    required this.recentSongs,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
  });

  HomeLoaded copyWith({
    List<Event>? seminars,
    List<WeeklyProgramItem>? weeklyProgram,
    Verse? memoryVerse,
    Song? currentSong,
    List<Song>? recentSongs,
    bool? isPlaying,
    Duration? currentPosition,
  }) {
    return HomeLoaded(
      seminars: seminars ?? this.seminars,
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
        seminars,
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
