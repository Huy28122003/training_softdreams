import 'package:training_softdreams/data/models/animal.dart';
import 'package:training_softdreams/data/network/firebase/animal_firebase.dart';

abstract class AnimalFirebaseDataSources {
  Future<List<Animal>> getAnimals();

  Future<void> addAnimal(Animal animal);
}

class AnimalFirebaseDataSourcesImpl extends AnimalFirebaseDataSources {
  final AnimalFirebase _animalFirebase;

  AnimalFirebaseDataSourcesImpl(this._animalFirebase);

  @override
  Future<void> addAnimal(Animal animal) async {
    await _animalFirebase.addAnimal(animal);
  }

  @override
  Future<List<Animal>> getAnimals() async {
    return await _animalFirebase.getAnimals();
  }
}
