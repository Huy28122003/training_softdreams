import 'package:dartz/dartz.dart';

import '../../../domain/error/exception.dart';
import '../../error/failures.dart';
import '../../repository/token_repository.dart';
import '../usecase.dart';

class DeleteToken implements UseCase<bool, NoParams> {
  DeleteToken({
    required this.tokenRepository,
  });

  final TokenRepository tokenRepository;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) async {
    try {
      if (!tokenRepository.isLoggedIn) {
        throw const UnauthorisedException();
      }

      await tokenRepository.removeToken();
      return const Right(true);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
