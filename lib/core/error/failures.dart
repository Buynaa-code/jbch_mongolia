import 'package:equatable/equatable.dart';

/// Base failure class for the application
/// Used with `Either<Failure, T>` from dartz
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Failure returned when server returns an error
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Серверийн алдаа гарлаа. Дахин оролдоно уу',
    super.statusCode,
  });
}

/// Failure returned when there is no network connection
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Интернет холболт байхгүй байна. Холболтоо шалгана уу',
  });
}

/// Failure returned when cache operation fails
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Өгөгдөл хадгалахад алдаа гарлаа',
  });
}

/// Failure returned when user authentication fails
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Нэвтрэхэд алдаа гарлаа',
    super.statusCode,
  });
}

/// Failure returned when user is unauthorized
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Нэвтрэх эрхгүй байна. Дахин нэвтэрнэ үү',
    super.statusCode = 401,
  });
}

/// Failure returned when credentials are invalid
class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({
    super.message = 'И-мэйл эсвэл нууц үг буруу байна',
    super.statusCode = 401,
  });
}

/// Failure returned when email is already registered
class EmailAlreadyExistsFailure extends Failure {
  const EmailAlreadyExistsFailure({
    super.message = 'Энэ и-мэйл хаяг бүртгэлтэй байна',
    super.statusCode = 409,
  });
}

/// Failure returned when resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Хайсан зүйл олдсонгүй',
    super.statusCode = 404,
  });
}

/// Failure returned when validation fails
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure({
    super.message = 'Оруулсан мэдээлэл буруу байна',
    super.statusCode = 422,
    this.errors,
  });

  @override
  List<Object?> get props => [message, statusCode, errors];
}

/// Generic unexpected failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'Тодорхойгүй алдаа гарлаа. Дахин оролдоно уу',
  });
}
