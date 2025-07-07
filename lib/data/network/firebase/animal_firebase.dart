import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_softdreams/utils/constants/strings.dart';

import '../../../domain/models/animal.dart';

class AnimalFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const _collection = animalCollectionName;

  Future<void> addAnimal(Animal animal) async {
    try {
      await _firestore.collection(_collection).add(animal.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Animal>> getAnimals() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();
      return snapshot.docs
          .map((doc) => Animal.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> updateAnimal(Animal animal) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(animal.id)
          .update(animal.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAnimal(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
