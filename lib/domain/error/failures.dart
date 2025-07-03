import 'package:equatable/equatable.dart';

import 'exception.dart';

abstract class Failure extends Equatable {
  const Failure([this.message]);

  final String? message;

  factory Failure.fromException(dynamic exception) {
    if (exception is AppException) {
      if (exception is UnauthorisedException) {
        return AuthenticationFailure(exception.toString());
      }

      if (exception is ServerException) {
        return ServerFailure(exception.toString());
      }

      if (exception is CacheException) {
        return CacheFailure(exception.toString());
      }

      if (exception is NoInternetException) {
        return NoConnectionFailure(exception.toString());
      }

      if (exception is BadRequestException) {
        return BadRequestFailure(exception.toString());
      }

      if (exception is FileLargeException) {
        return FileLargeFailure(exception.toString());
      }
    }

    return UnknownFailure(exception.toString());
  }

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.message]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure([super.message]);
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure([super.message]);
}

class FileLargeFailure extends Failure {
  const FileLargeFailure([super.message]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}
