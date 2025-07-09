import 'package:training_softdreams/domain/entities/animal_entity.dart';

import '../models/animal.dart';

extension AnimalTranslator on Animal {
  AnimalEntity toEntity() => AnimalEntity(
        id: id,
        name: name,
        isHerbivores: isHerbivores,
        isEggLaying: isEggLaying,
        quantity: quantity,
      );
}
