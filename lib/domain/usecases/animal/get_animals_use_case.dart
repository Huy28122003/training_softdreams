import 'package:dartz/dartz.dart';
import 'package:training_softdreams/domain/models/animal.dart';
import 'package:training_softdreams/domain/repository/animal_repository.dart';
import 'package:training_softdreams/domain/repository/user_repository.dart';

import '../../error/failures.dart';
import '../usecase.dart';

class GetAnimalsUseCase implements UseCase<List<Animal>, NoParams> {
  GetAnimalsUseCase(this.animalRepository);

  final AnimalRepository animalRepository;

  @override
  Future<Either<Failure, List<Animal>>> call([NoParams? param]) async {
    try {
      final animals = await animalRepository.getAnimals();
      return Right(animals);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
