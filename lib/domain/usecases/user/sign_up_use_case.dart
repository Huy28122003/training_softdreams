import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../repository/user_repository.dart';
import '../usecase.dart';

class SignUpUseCase implements UseCase<Tuple2<bool, String>, SignUpArguments> {
  SignUpUseCase(this.userRepository);

  final UserRepository userRepository;

  @override
  Future<Either<Failure, Tuple2<bool, String>>> call(
      SignUpArguments param) async {
    try {
      final url = await userRepository.signUp(param.email, param.password);
      return Right(url);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}

class SignUpArguments {
  final String email;
  final String password;

  SignUpArguments({required this.email, required this.password});
}
