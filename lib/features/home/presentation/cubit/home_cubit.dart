import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../events/domain/entities/event.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/entities/sunday_schedule.dart';
import '../../domain/entities/weekly_program.dart';
import '../../domain/usecases/get_home_data.dart';
import 'home_state.dart';

/// Cubit for managing Home feature state
@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetUpcomingSeminarsUseCase _getUpcomingSeminarsUseCase;
  final GetWeeklyProgramUseCase _getWeeklyProgramUseCase;
  final GetMemoryVerseUseCase _getMemoryVerseUseCase;
  final GetFeaturedSongsUseCase _getFeaturedSongsUseCase;
  final GetSundaySchedulesUseCase _getSundaySchedulesUseCase;
  final GetAnnouncementsUseCase _getAnnouncementsUseCase;

  HomeCubit(
    this._getUpcomingSeminarsUseCase,
    this._getWeeklyProgramUseCase,
    this._getMemoryVerseUseCase,
    this._getFeaturedSongsUseCase,
    this._getSundaySchedulesUseCase,
    this._getAnnouncementsUseCase,
  ) : super(const HomeInitial());

  /// Load home data
  Future<void> loadHomeData() async {
    emit(const HomeLoading());

    try {
      // Load all data in parallel for better performance
      final results = await Future.wait([
        _getUpcomingSeminarsUseCase(),
        _getWeeklyProgramUseCase(),
        _getMemoryVerseUseCase(),
        _getFeaturedSongsUseCase(),
        _getSundaySchedulesUseCase(),
        _getAnnouncementsUseCase(),
      ]);

      final seminarsResult = results[0];
      final weeklyProgramResult = results[1];
      final memoryVerseResult = results[2];
      final featuredSongsResult = results[3];
      final sundaySchedulesResult = results[4];
      final announcementsResult = results[5];

      // Get data with proper types - don't block on individual failures
      final List<Event> seminars = seminarsResult.fold(
        (_) => <Event>[],
        (data) => data is List<Event> ? data : <Event>[],
      );
      final List<WeeklyProgramItem> weeklyProgram = weeklyProgramResult.fold(
        (_) => <WeeklyProgramItem>[],
        (data) => data is List<WeeklyProgramItem> ? data : <WeeklyProgramItem>[],
      );
      final Verse? memoryVerse = memoryVerseResult.fold(
        (_) => null,
        (verse) => verse is Verse ? verse : null,
      );
      final List<Song> featuredSongs = featuredSongsResult.fold(
        (_) => <Song>[],
        (data) => data is List<Song> ? data : <Song>[],
      );
      final List<Announcement> announcements = announcementsResult.fold(
        (_) => <Announcement>[],
        (data) => data is List<Announcement> ? data : <Announcement>[],
      );

      // Get sunday schedules from API
      SundaySchedule? currentSundaySchedule;
      SundaySchedule? nextSundaySchedule;
      sundaySchedulesResult.fold(
        (_) {}, // Ignore error, schedules are optional
        (data) {
          if (data is ({SundaySchedule? current, SundaySchedule? next})) {
            currentSundaySchedule = data.current;
            nextSundaySchedule = data.next;
          }
        },
      );

      // Only show error if ALL data failed to load
      if (seminars.isEmpty && weeklyProgram.isEmpty && memoryVerse == null && featuredSongs.isEmpty && announcements.isEmpty) {
        emit(const HomeError('Өгөгдөл ачаалахад алдаа гарлаа. Интернэт холболтоо шалгана уу.'));
        return;
      }

      emit(HomeLoaded(
        announcements: announcements,
        seminars: seminars,
        weeklyProgram: weeklyProgram,
        memoryVerse: memoryVerse,
        currentSong: featuredSongs.isNotEmpty ? featuredSongs.first : null,
        recentSongs: featuredSongs,
        currentSundaySchedule: currentSundaySchedule,
        nextSundaySchedule: nextSundaySchedule,
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
  void setCurrentSong(Song song) {
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
