import 'package:equatable/equatable.dart';

/// User profile entity
class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String memberSince;
  final String? profileImageUrl;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.memberSince,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [id, name, email, memberSince, profileImageUrl];

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? memberSince,
    String? profileImageUrl,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      memberSince: memberSince ?? this.memberSince,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
