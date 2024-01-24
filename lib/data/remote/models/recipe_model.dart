import 'package:json_annotation/json_annotation.dart';

import '../../../configuration/app_environtment.dart';
import '../../../domain/entities/recipe.dart';
import 'ingredient_model.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
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

  RecipeModel({
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

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  Recipe toEntity() {
    return Recipe(
      uuid: uuid,
      title: title,
      description: description,
      image: AppEnvironment.imageUrl + (image ?? ''),
      ingredients: ingredients,
      instructions: instructions,
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      utensils: utensils,
    );
  }
}
