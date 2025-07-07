import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../utils/constants/strings.dart';

class StatusCode {
  StatusCode._();

  static const int ok = 200;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int entityTooLarge = 413;
  static const int serverError = 500;

  static const int requestCancelled = 1100;
  static const int connectTimeout = 1101;
  static const int socketError = 1102;
  static const int receiveTimeout = 1103;
  static const int sendTimeout = 1104;

  static const int duplicate = 409;
  static const int precondition = 412;
  static const int unavailable = 503;
}

class AppException extends Equatable implements Exception {
  const AppException([this._message = '', this._prefix = '']);

  factory AppException.throwException(dynamic exception) {
    if (exception is DioException) {
      final statusCode = _getStatusCode(exception);

      switch (statusCode.value1) {
        case StatusCode.unauthorized:
        case StatusCode.forbidden:
          return const UnauthorisedException();
        case StatusCode.badRequest:
          return BadRequestException(statusCode.value2);
        case StatusCode.socketError:
          return const NoInternetException();
        default:
          return const ServerException();
      }
    } else if (exception is FirebaseException) {
      return _fromFirebase(exception);
    } else if (exception is AppException) {
      return exception;
    }

    return UnknownException(exception.toString());
  }

  static AppException _fromFirebase(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
      case 'unauthenticated':
        return const UnauthorisedException();

      case 'not-found':
        return RemoteException(StatusCode.notFound, e.message);

      case 'already-exists':
        return RemoteException(StatusCode.duplicate, e.message);

      case 'failed-precondition':
      case 'invalid-argument':
        return BadRequestException(e.message);

      case 'unavailable':
      case 'deadline-exceeded':
        return RemoteException(StatusCode.unavailable, e.message);

      case 'internal':
        return const ServerException();

      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return BadRequestException('Email đã được sử dụng');

      case 'weak-password':
        return BadRequestException('Mật khẩu quá yếu');

      case 'wrong-password':
      case 'user-not-found':
        return const UnauthorisedException();

      default:
        return UnknownException(e.message);
    }
  }

  static Tuple2<int, String?> _getStatusCode(DioException error) {
    int? code;
    String? message;

    switch (error.type) {
      case DioExceptionType.cancel:
        code = StatusCode.requestCancelled;
        break;
      case DioExceptionType.connectionTimeout:
        code = StatusCode.connectTimeout;
        break;

      case DioExceptionType.connectionError:
        code = StatusCode.socketError;
        break;
      case DioExceptionType.receiveTimeout:
        code = StatusCode.receiveTimeout;
        break;
      case DioExceptionType.badResponse:
        final dynamic responseData = error.response!.data;
        if (responseData is Map<String, dynamic>) {
          code = responseData['code'] ?? error.response!.statusCode;
          message = responseData['error_description'];
        } else {
          code = error.response!.statusCode;
        }
        break;
      case DioExceptionType.sendTimeout:
        code = StatusCode.sendTimeout;
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        break;
    }

    code = code ?? StatusCode.serverError;

    return Tuple2(code, message);
  }

  final String? _message;
  final String _prefix;

  String? get message => _message;

  @override
  String toString() => '$_prefix$_message';

  @override
  List<Object?> get props => [_message, _prefix];
}

class UnauthorisedException extends AppException {
  const UnauthorisedException() : super(authenticationError);
}

class ServerException extends AppException {
  const ServerException() : super(serverError);
}

class CacheException extends AppException {
  const CacheException() : super(cacheError);
}

class NoInternetException extends AppException {
  const NoInternetException() : super(socketError);
}

class BadRequestException extends AppException {
  const BadRequestException([String? message])
      : super(message, 'Request Invalid: ');
}

class UnknownException extends AppException {
  const UnknownException(String? message) : super(message, 'Unkown error: ');
}

class RemoteException extends AppException {
  const RemoteException(int? code, [String? message])
      : code = code ?? StatusCode.serverError,
        super(message);

  final int code;
}

class FileLargeException extends AppException {
  const FileLargeException() : super(fileLargeError);
}

class FirebaseEmailAlreadyExistsException extends AppException {
  const FirebaseEmailAlreadyExistsException() : super(emailAlreadyExistsError);
}

class FirebaseInvalidEmailException extends AppException {
  const FirebaseInvalidEmailException() : super(invalidEmailError);
}

class FirebaseInvalidPasswordException extends AppException {
  const FirebaseInvalidPasswordException() : super(invalidPasswordError);
}
