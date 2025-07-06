
import '../models/animal.dart';

abstract class AnimalRepository {
  Future<void> addAnimal(Animal animal);

  Future<List<Animal>> getAnimals();

  Future<void> updateAnimal(Animal animal);

  Future<void> deleteAnimal(String id);
}
