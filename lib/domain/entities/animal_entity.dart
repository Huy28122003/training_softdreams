class AnimalEntity {
  final String? id;
  final String name;

  final bool isHerbivores;

  final bool isEggLaying;

  final int quantity;

  AnimalEntity({
    this.id,
    required this.name,
    required this.isHerbivores,
    required this.isEggLaying,
    required this.quantity,
  });
}
