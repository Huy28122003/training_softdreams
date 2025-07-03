import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../usecase.dart';

class GetAuthorizedUser implements UseCase<String, NoParams> {
  GetAuthorizedUser();

  @override
  Future<Either<Failure, String>> call([NoParams? params]) async {
    try {
      // TODO: get authorized user
      return const Right('test');
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
