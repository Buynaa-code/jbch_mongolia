import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_tokens.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for user registration
@lazySingleton
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, (User, AuthTokens)>> call(RegisterParams params) {
    return _repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      phone: params.phone,
    );
  }
}

/// Parameters for register use case
class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final String? phone;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, name, phone];
}
