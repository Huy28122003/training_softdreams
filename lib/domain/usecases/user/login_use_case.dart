import 'package:dartz/dartz.dart';
import 'package:training_softdreams/domain/repository/user_repository.dart';

import '../../error/failures.dart';
import '../usecase.dart';

class LoginUseCase implements UseCase<Tuple2<bool, String>, LoginArguments> {
  LoginUseCase(this.userRepository);

  final UserRepository userRepository;

  @override
  Future<Either<Failure, Tuple2<bool, String>>> call(
      LoginArguments param) async {
    try {
      final url = await userRepository.login(param.email, param.password);
      return Right(url);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}

class LoginArguments {
  final String email;
  final String password;

  LoginArguments({required this.email, required this.password});
}
