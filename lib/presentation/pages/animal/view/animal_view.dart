import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/enums.dart';
import '../../../../domain/entities/animal_entity.dart';
import '../controller/animal_controller.dart';


class AnimalView extends GetView<AnimalController> {
  const AnimalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal List"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.status.value == LoadingStatus.loading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (controller.status.value == LoadingStatus.failure) {
          return const SizedBox();
        }
        return ListView.builder(
          itemCount: controller.animals.length,
          itemBuilder: (context, index) {
            final animal = controller.animals[index];
            return ListTile(
              leading: Text(animal.name),
              title: Text(animal.isHerbivores ? "Herbivores" : "Carnivores"),
              subtitle: Text(
                  'Reproduction: ${animal.isEggLaying ? "Egg Laying" : "Giving birth"}'),
              trailing: Text('SL: ${animal.quantity}'),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final random = Random();
          controller.addAnimal(
            AnimalEntity(
              name: 'Unknown',
              isHerbivores: random.nextBool(),
              isEggLaying: random.nextBool(),
              quantity: random.nextInt(100),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
