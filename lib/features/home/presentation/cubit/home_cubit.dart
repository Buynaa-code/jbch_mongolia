import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../events/domain/entities/event.dart';
import '../../../library/domain/entities/song.dart';
import '../../../library/domain/entities/verse.dart';
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

  HomeCubit(
    this._getUpcomingSeminarsUseCase,
    this._getWeeklyProgramUseCase,
    this._getMemoryVerseUseCase,
    this._getFeaturedSongsUseCase,
  ) : super(const HomeInitial());

  /// Load home data
  Future<void> loadHomeData() async {
    emit(const HomeLoading());

    try {
      // Load all data separately to maintain type safety
      final seminarsResult = await _getUpcomingSeminarsUseCase();
      final weeklyProgramResult = await _getWeeklyProgramUseCase();
      final memoryVerseResult = await _getMemoryVerseUseCase();
      final featuredSongsResult = await _getFeaturedSongsUseCase();

      // Check for critical failures
      String? errorMessage;

      weeklyProgramResult.fold(
        (failure) => errorMessage = failure.message,
        (_) {},
      );
      if (errorMessage != null) {
        emit(HomeError(errorMessage!));
        return;
      }

      memoryVerseResult.fold(
        (failure) => errorMessage = failure.message,
        (_) {},
      );
      if (errorMessage != null) {
        emit(HomeError(errorMessage!));
        return;
      }

      // Get the data with proper types
      final List<Event> seminars = seminarsResult.fold(
        (_) => <Event>[],
        (data) => data,
      );
      final List<WeeklyProgramItem> weeklyProgram = weeklyProgramResult.fold(
        (_) => <WeeklyProgramItem>[],
        (data) => data,
      );
      final Verse memoryVerse = memoryVerseResult.fold(
        (failure) => throw Exception(failure.message),
        (verse) => verse,
      );
      final List<Song> featuredSongs = featuredSongsResult.fold(
        (_) => <Song>[],
        (data) => data,
      );

      emit(HomeLoaded(
        seminars: seminars,
        weeklyProgram: weeklyProgram,
        memoryVerse: memoryVerse,
        currentSong: featuredSongs.isNotEmpty ? featuredSongs.first : null,
        recentSongs: featuredSongs,
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
