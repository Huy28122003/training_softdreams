import 'package:get/get.dart';

import '../../../../configs/enums.dart';
import '../../../../domain/models/animal.dart';
import '../../../../domain/usecases/animal/add_animal_use_case.dart';
import '../../../../domain/usecases/animal/get_animals_use_case.dart';

class AnimalController extends GetxController {
  var animals = <Animal>[].obs;
  var status = LoadingStatus.initial.obs;

  final GetAnimalsUseCase getAnimalsUseCase;
  final AddAnimalUseCase addAnimalUseCase;

  AnimalController({
    required this.getAnimalsUseCase,
    required this.addAnimalUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    fetchAnimals();
  }

  Future<void> fetchAnimals() async {
    try {
      status.value = LoadingStatus.loading;
      final result = await getAnimalsUseCase.call();
      result.fold(
        (error) {
          status.value = LoadingStatus.failure;
          Get.snackbar('Error', error.toString());
        },
        (data) {
          animals.value = data;
          status.value = LoadingStatus.success;
        },
      );
    } catch (e) {
      status.value = LoadingStatus.failure;
    }
  }

  Future<void> addAnimal(Animal animal) async {
    try {
      status.value = LoadingStatus.loading;
      final result = await addAnimalUseCase.call(animal);
      result.fold(
        (error) {
          status.value = LoadingStatus.failure;
        },
        (_) {
          fetchAnimals();
        },
      );
    } catch (e) {
      status.value = LoadingStatus.failure;
    }
  }
}
