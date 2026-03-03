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
    final data = response.data as Map<String, dynamic>;
    final songsList = data['songs'] as List<dynamic>;
    return songsList
        .map((e) => SongModel.fromJson(e as Map<String, dynamic>))
        .toList();
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

  @override
  Future<SongModel> getSongById(String id) async {
    final response = await _dioClient.get(ApiConstants.songById(id));
    final data = response.data as Map<String, dynamic>;
    return SongModel.fromJson(data['song'] as Map<String, dynamic>);
  }

  @override
  Future<SongModel> toggleSongFavorite(String id) async {
    final response = await _dioClient.post(ApiConstants.toggleSongFavorite(id));
    final data = response.data as Map<String, dynamic>;
    return SongModel.fromJson(data['song'] as Map<String, dynamic>);
  }

  // ============ Verses ============

  @override
  Future<List<VerseModel>> getVerses() async {
    final response = await _dioClient.get(ApiConstants.verses);
    final data = response.data as Map<String, dynamic>;
    final versesList = data['verses'] as List<dynamic>;
    return versesList
        .map((e) => VerseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<VerseModel> getVerseOfWeek() async {
    final response = await _dioClient.get(ApiConstants.verseOfWeek);
    final data = response.data as Map<String, dynamic>;
    return VerseModel.fromJson(data['verse'] as Map<String, dynamic>);
  }

  @override
  Future<VerseModel> getVerseById(String id) async {
    final response = await _dioClient.get(ApiConstants.verseById(id));
    final data = response.data as Map<String, dynamic>;
    return VerseModel.fromJson(data['verse'] as Map<String, dynamic>);
  }

  @override
  Future<VerseModel> toggleVerseFavorite(String id) async {
    final response =
        await _dioClient.post(ApiConstants.toggleVerseFavorite(id));
    final data = response.data as Map<String, dynamic>;
    return VerseModel.fromJson(data['verse'] as Map<String, dynamic>);
  }

  // ============ Sermons ============

  @override
  Future<List<SermonModel>> getSermons() async {
    final response = await _dioClient.get(ApiConstants.sermons);
    final data = response.data as Map<String, dynamic>;
    final sermonsList = data['sermons'] as List<dynamic>;
    return sermonsList
        .map((e) => SermonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SermonModel>> getRecentSermons() async {
    final response = await _dioClient.get(ApiConstants.recentSermons);
    final data = response.data as Map<String, dynamic>;
    final sermonsList = data['sermons'] as List<dynamic>;
    return sermonsList
        .map((e) => SermonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<SermonModel> getSermonById(String id) async {
    final response = await _dioClient.get(ApiConstants.sermonById(id));
    final data = response.data as Map<String, dynamic>;
    return SermonModel.fromJson(data['sermon'] as Map<String, dynamic>);
  }

  @override
  Future<SermonModel> toggleSermonFavorite(String id) async {
    final response =
        await _dioClient.post(ApiConstants.toggleSermonFavorite(id));
    final data = response.data as Map<String, dynamic>;
    return SermonModel.fromJson(data['sermon'] as Map<String, dynamic>);
  }
}
