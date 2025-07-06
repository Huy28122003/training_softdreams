import 'package:get/get.dart';
import 'package:training_softdreams/di/locator.dart';
import 'package:training_softdreams/domain/usecases/animal/add_animal_use_case.dart';
import 'package:training_softdreams/domain/usecases/animal/get_animals_use_case.dart';
import 'package:training_softdreams/presentation/pages/animal/controller/animal_controller.dart';

class AnimalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AnimalController(
        getAnimalsUseCase: locator<GetAnimalsUseCase>(),
        addAnimalUseCase: locator<AddAnimalUseCase>(),
      ),
    );
  }
}
