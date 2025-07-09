
import 'package:training_softdreams/data/translators/animal_translator.dart';

import '../../domain/entities/animal_entity.dart';
import '../../domain/repository/animal_repository.dart';
import '../models/animal.dart';
import '../network/firebase/data_sources/animal_firebase_data_sources.dart';

class AnimalRepositoryImpl extends AnimalRepository {
  final AnimalFirebaseDataSources animalFirebaseDataSources;

  AnimalRepositoryImpl({required this.animalFirebaseDataSources});

  @override
  Future<void> addAnimal(AnimalEntity animal) async {
    try {
      await animalFirebaseDataSources.addAnimal(
        Animal(
          name: animal.name,
          isHerbivores: animal.isHerbivores,
          isEggLaying: animal.isEggLaying,
          quantity: animal.quantity,
        ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AnimalEntity>> getAnimals() async {
    try {
      final result = await animalFirebaseDataSources.getAnimals();
      return result.map((e) => e.toEntity()).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
