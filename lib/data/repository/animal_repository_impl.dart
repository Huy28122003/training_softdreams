import 'package:dartz/dartz.dart';
import 'package:training_softdreams/data/network/firebase/animal_firebase.dart';
import 'package:training_softdreams/domain/models/animal.dart';
import 'package:training_softdreams/domain/repository/animal_repository.dart';
import '../../domain/repository/user_repository.dart';
import '../network/firebase/user_firebase.dart';

class AnimalRepositoryImpl extends AnimalRepository {
  final AnimalFirebase animalFirebase;

  AnimalRepositoryImpl({required this.animalFirebase});

  @override
  Future<void> addAnimal(Animal animal) async {
    try {
      await animalFirebase.addAnimal(animal);
    } catch (e) {}
  }

  @override
  Future<void> deleteAnimal(String id) async {
    try {
      await animalFirebase.deleteAnimal(id);
    } catch (e) {}
  }

  @override
  Future<List<Animal>> getAnimals() async {
    try {
      return await animalFirebase.getAnimals();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateAnimal(Animal animal) async {
    try {
      await animalFirebase.updateAnimal(animal);
    } catch (e) {}
  }
}
