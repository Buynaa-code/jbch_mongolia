import 'package:equatable/equatable.dart';

/// User entity representing an authenticated user
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatarUrl;
  final String? role;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatarUrl,
    this.role,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, email, name, phone, avatarUrl, role, createdAt];
}
