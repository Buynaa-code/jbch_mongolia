import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, UserProfile>> call({
    String? name,
    String? email,
    String? profileImageUrl,
  }) {
    return repository.updateProfile(
      name: name,
      email: email,
      profileImageUrl: profileImageUrl,
    );
  }
}
