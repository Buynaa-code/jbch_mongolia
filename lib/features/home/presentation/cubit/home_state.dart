import 'package:equatable/equatable.dart';

import '../../../events/domain/entities/event.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/entities/sunday_schedule.dart';
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
  final List<Announcement> announcements;
  final List<Event> seminars;
  final List<WeeklyProgramItem> weeklyProgram;
  final Verse? memoryVerse;
  final Song? currentSong;
  final List<Song> recentSongs;
  final bool isPlaying;
  final Duration currentPosition;
  final SundaySchedule? currentSundaySchedule;
  final SundaySchedule? nextSundaySchedule;

  const HomeLoaded({
    this.announcements = const [],
    this.seminars = const [],
    required this.weeklyProgram,
    this.memoryVerse,
    this.currentSong,
    required this.recentSongs,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
    this.currentSundaySchedule,
    this.nextSundaySchedule,
  });

  HomeLoaded copyWith({
    List<Announcement>? announcements,
    List<Event>? seminars,
    List<WeeklyProgramItem>? weeklyProgram,
    Verse? memoryVerse,
    bool clearMemoryVerse = false,
    Song? currentSong,
    bool clearCurrentSong = false,
    List<Song>? recentSongs,
    bool? isPlaying,
    Duration? currentPosition,
    SundaySchedule? currentSundaySchedule,
    bool clearCurrentSundaySchedule = false,
    SundaySchedule? nextSundaySchedule,
    bool clearNextSundaySchedule = false,
  }) {
    return HomeLoaded(
      announcements: announcements ?? this.announcements,
      seminars: seminars ?? this.seminars,
      weeklyProgram: weeklyProgram ?? this.weeklyProgram,
      memoryVerse: clearMemoryVerse ? null : (memoryVerse ?? this.memoryVerse),
      currentSong: clearCurrentSong ? null : (currentSong ?? this.currentSong),
      recentSongs: recentSongs ?? this.recentSongs,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      currentSundaySchedule: clearCurrentSundaySchedule
          ? null
          : (currentSundaySchedule ?? this.currentSundaySchedule),
      nextSundaySchedule: clearNextSundaySchedule
          ? null
          : (nextSundaySchedule ?? this.nextSundaySchedule),
    );
  }

  @override
  List<Object?> get props => [
        announcements,
        seminars,
        weeklyProgram,
        memoryVerse,
        currentSong,
        recentSongs,
        isPlaying,
        currentPosition,
        currentSundaySchedule,
        nextSundaySchedule,
      ];
}

/// Error state when something goes wrong
final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
