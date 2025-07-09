import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable()
class Animal {
  final String? id;
  final String name;

  @JsonKey(name: 'herbivores')
  final bool isHerbivores;

  @JsonKey(name: 'egg_laying')
  final bool isEggLaying;

  final int quantity;

  Animal({
    this.id,
    required this.name,
    required this.isHerbivores,
    required this.isEggLaying,
    required this.quantity,
  });

  factory Animal.fromJson(Map<String, dynamic> json, String id) =>
      _$AnimalFromJson(json).copyWith(id: id);

  Map<String, dynamic> toJson() => _$AnimalToJson(this);

  Animal copyWith({
    String? id,
    String? name,
    bool? isHerbivores,
    bool? isEggLaying,
    int? quantity,
  }) =>
      Animal(
        id: id ?? this.id,
        name: name ?? this.name,
        isHerbivores: isHerbivores ?? this.isHerbivores,
        isEggLaying: isEggLaying ?? this.isEggLaying,
        quantity: quantity ?? this.quantity,
      );
}
