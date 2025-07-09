import 'package:dartz/dartz.dart';

import '../../entities/animal_entity.dart';
import '../../error/failures.dart';
import '../../repository/animal_repository.dart';
import '../usecase.dart';

class AddAnimalUseCase implements UseCase<void, AnimalEntity> {
  AddAnimalUseCase(this.animalRepository);

  final AnimalRepository animalRepository;

  @override
  Future<Either<Failure, void>> call(AnimalEntity param) async {
    try {
      await animalRepository.addAnimal(param);
      return Right(null);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
