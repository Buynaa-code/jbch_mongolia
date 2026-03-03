import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../library/data/models/song_model.dart';
import '../../../library/data/models/verse_model.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  /// Get user profile
  Future<UserProfileModel> getProfile();

  /// Update user profile
  Future<UserProfileModel> updateProfile({
    String? name,
    String? email,
    String? profileImageUrl,
  });

  /// Get user's favorite songs
  Future<List<SongModel>> getFavoriteSongs();

  /// Get user's favorite verses
  Future<List<VerseModel>> getFavoriteVerses();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _dioClient;

  ProfileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserProfileModel> getProfile() async {
    try {
      final response = await _dioClient.get(ApiConstants.userProfile);
      return UserProfileModel.fromJson(response.data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserProfileModel> updateProfile({
    String? name,
    String? email,
    String? profileImageUrl,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (email != null) data['email'] = email;
      if (profileImageUrl != null) data['profileImageUrl'] = profileImageUrl;

      final response = await _dioClient.put(
        ApiConstants.userProfile,
        data: data,
      );
      return UserProfileModel.fromJson(response.data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<SongModel>> getFavoriteSongs() async {
    try {
      final response = await _dioClient.get(ApiConstants.userFavoriteSongs);
      final List<dynamic> data = response.data;
      return data.map((json) => SongModel.fromJson(json)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<VerseModel>> getFavoriteVerses() async {
    try {
      final response = await _dioClient.get(ApiConstants.userFavoriteVerses);
      final List<dynamic> data = response.data;
      return data.map((json) => VerseModel.fromJson(json)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
