import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.memberSince,
    super.profileImageUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      memberSince: json['memberSince'] as String? ?? '',
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      memberSince: entity.memberSince,
      profileImageUrl: entity.profileImageUrl,
    );
  }
}
