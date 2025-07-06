import 'package:dartz/dartz.dart';
import 'package:training_softdreams/domain/models/animal.dart';
import 'package:training_softdreams/domain/repository/animal_repository.dart';
import 'package:training_softdreams/domain/repository/user_repository.dart';

import '../../error/failures.dart';
import '../usecase.dart';

class AddAnimalUseCase implements UseCase<void, Animal> {
  AddAnimalUseCase(this.animalRepository);

  final AnimalRepository animalRepository;

  @override
  Future<Either<Failure, void>> call(Animal param) async {
    try {
      await animalRepository.addAnimal(param);
      return Right(null);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
