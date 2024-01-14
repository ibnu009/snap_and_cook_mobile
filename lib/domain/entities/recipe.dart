import 'package:json_annotation/json_annotation.dart';

import '../../data/remote/models/ingredient_model.dart';

@JsonSerializable()
class Recipe {
  String? uuid;
  String? title;
  String? description;
  String? image;
  List<Ingredient>? ingredients;
  List<String>? instructions;
  int? prepTime;
  int? cookTime;
  int? servings;
  List<String>? utensils;

  Recipe({
    this.uuid,
    this.title,
    this.description,
    this.image,
    this.ingredients,
    this.instructions,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.utensils,
  });
}
