import 'package:injectable/injectable.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/sermon_model.dart';
import '../models/song_model.dart';
import '../models/verse_model.dart';

/// Remote data source for library API calls
abstract class LibraryRemoteDataSource {
  // Songs
  Future<List<SongModel>> getSongs();
  Future<List<SongModel>> getFeaturedSongs();
  Future<SongModel> getSongById(String id);
  Future<SongModel> toggleSongFavorite(String id);

  // Verses
  Future<List<VerseModel>> getVerses();
  Future<VerseModel> getVerseOfWeek();
  Future<VerseModel> getVerseById(String id);
  Future<VerseModel> toggleVerseFavorite(String id);

  // Sermons
  Future<List<SermonModel>> getSermons();
  Future<List<SermonModel>> getRecentSermons();
  Future<SermonModel> getSermonById(String id);
  Future<SermonModel> toggleSermonFavorite(String id);
}

@LazySingleton(as: LibraryRemoteDataSource)
class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final DioClient _dioClient;

  LibraryRemoteDataSourceImpl(this._dioClient);

  // ============ Songs ============

  @override
  Future<List<SongModel>> getSongs() async {
    final response = await _dioClient.get(ApiConstants.songs);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return data
        .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SongModel>> getFeaturedSongs() async {
    final response = await _dioClient.get(ApiConstants.featuredSongs);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return data
        .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<SongModel> getSongById(String id) async {
    final response = await _dioClient.get(ApiConstants.songById(id));
    final responseData = response.data as Map<String, dynamic>;
    return SongModel.fromJson(responseData['data'] as Map<String, dynamic>);
  }

  @override
  Future<SongModel> toggleSongFavorite(String id) async {
    final response = await _dioClient.post(ApiConstants.toggleSongFavorite(id));
    final responseData = response.data as Map<String, dynamic>;
    return SongModel.fromJson(responseData['data'] as Map<String, dynamic>);
  }

  // ============ Verses ============

  @override
  Future<List<VerseModel>> getVerses() async {
    final response = await _dioClient.get(ApiConstants.verses);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return data
        .map((e) => VerseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<VerseModel> getVerseOfWeek() async {
    final response = await _dioClient.get(ApiConstants.verseOfWeek);
    final responseData = response.data as Map<String, dynamic>;
    return VerseModel.fromJson(responseData['data'] as Map<String, dynamic>);
  }

  @override
  Future<VerseModel> getVerseById(String id) async {
    final response = await _dioClient.get(ApiConstants.verseById(id));
    final responseData = response.data as Map<String, dynamic>;
    return VerseModel.fromJson(responseData['data'] as Map<String, dynamic>);
  }

  @override
  Future<VerseModel> toggleVerseFavorite(String id) async {
    final response =
        await _dioClient.post(ApiConstants.toggleVerseFavorite(id));
    final responseData = response.data as Map<String, dynamic>;
    return VerseModel.fromJson(responseData['data'] as Map<String, dynamic>);
  }

  // ============ Sermons ============

  @override
  Future<List<SermonModel>> getSermons() async {
    final response = await _dioClient.get(ApiConstants.sermons);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return data
        .map((e) => SermonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SermonModel>> getRecentSermons() async {
    final response = await _dioClient.get(ApiConstants.recentSermons);
    final responseData = response.data as Map<String, dynamic>;
    final data = responseData['data'];
    if (data == null || data is! List) {
      return [];
    }
    return data
        .map((e) => SermonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<SermonModel> getSermonById(String id) async {
    final response = await _dioClient.get(ApiConstants.sermonById(id));
    final responseData = response.data as Map<String, dynamic>;
    return SermonModel.fromJson(responseData['data'] as Map<String, dynamic>);
  }

  @override
  Future<SermonModel> toggleSermonFavorite(String id) async {
    final response =
        await _dioClient.post(ApiConstants.toggleSermonFavorite(id));
    final responseData = response.data as Map<String, dynamic>;
    return SermonModel.fromJson(responseData['data'] as Map<String, dynamic>);
  }
}
