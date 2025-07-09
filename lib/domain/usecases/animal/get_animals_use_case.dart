import 'package:dartz/dartz.dart';


import '../../entities/animal_entity.dart';
import '../../error/failures.dart';
import '../../repository/animal_repository.dart';
import '../usecase.dart';

class GetAnimalsUseCase implements UseCase<List<AnimalEntity>, NoParams> {
  GetAnimalsUseCase(this.animalRepository);

  final AnimalRepository animalRepository;

  @override
  Future<Either<Failure, List<AnimalEntity>>> call([NoParams? param]) async {
    try {
      final animals = await animalRepository.getAnimals();
      return Right(animals);
    } catch (error) {
      return Left(Failure.fromException(error));
    }
  }
}
