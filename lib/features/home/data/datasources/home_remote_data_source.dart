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
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return (data)
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<WeeklyProgramItemModel>> getWeeklyProgram() async {
    final response = await _dioClient.get(ApiConstants.weeklyProgram);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return (data)
        .map((e) =>
            WeeklyProgramItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<VerseModel> getMemoryVerse() async {
    final response = await _dioClient.get(ApiConstants.verseOfWeek);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'] as Map<String, dynamic>;
    return VerseModel.fromJson(data);
  }

  @override
  Future<List<SongModel>> getFeaturedSongs() async {
    final response = await _dioClient.get(ApiConstants.featuredSongs);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return (data)
        .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
