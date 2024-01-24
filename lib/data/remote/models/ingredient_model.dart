import 'package:json_annotation/json_annotation.dart';

part 'ingredient_model.g.dart';

@JsonSerializable()
class Ingredient {
  String? name;
  double? quantity;
  String? unit;

  Ingredient({
    this.name,
    this.quantity,
    this.unit,
  });

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}