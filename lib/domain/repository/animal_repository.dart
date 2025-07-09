

import '../entities/animal_entity.dart';

abstract class AnimalRepository {
  Future<void> addAnimal(AnimalEntity animal);

  Future<List<AnimalEntity>> getAnimals();
}
