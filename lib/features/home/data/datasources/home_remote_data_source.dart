import 'package:injectable/injectable.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../events/data/models/event_model.dart';
import '../../../library/data/models/song_model.dart';
import '../../../library/data/models/verse_model.dart';
import '../models/weekly_program_model.dart';

/// Remote data source for home page API calls
abstract class HomeRemoteDataSource {
  /// Get upcoming seminars
  Future<List<EventModel>> getUpcomingSeminars();

  /// Get weekly program
  Future<List<WeeklyProgramItemModel>> getWeeklyProgram();

  /// Get memory verse of the week
  Future<VerseModel> getMemoryVerse();

  /// Get featured songs
  Future<List<SongModel>> getFeaturedSongs();
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dioClient;

  HomeRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<EventModel>> getUpcomingSeminars() async {
    final response = await _dioClient.get(ApiConstants.upcomingEvents);
    final data = response.data as Map<String, dynamic>;
    final eventsList = data['events'] as List<dynamic>;
    return eventsList
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<WeeklyProgramItemModel>> getWeeklyProgram() async {
    final response = await _dioClient.get(ApiConstants.weeklyProgram);
    final data = response.data as Map<String, dynamic>;
    final programList = data['program'] as List<dynamic>;
    return programList
        .map((e) =>
            WeeklyProgramItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<VerseModel> getMemoryVerse() async {
    final response = await _dioClient.get(ApiConstants.verseOfWeek);
    final data = response.data as Map<String, dynamic>;
    return VerseModel.fromJson(data['verse'] as Map<String, dynamic>);
  }

  @override
  Future<List<SongModel>> getFeaturedSongs() async {
    final response = await _dioClient.get(ApiConstants.featuredSongs);
    final data = response.data as Map<String, dynamic>;
    final songsList = data['songs'] as List<dynamic>;
    return songsList
        .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
