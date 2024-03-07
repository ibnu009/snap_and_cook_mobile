// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detect_ingredient_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectIngredientRequest _$DetectIngredientRequestFromJson(
        Map<String, dynamic> json) =>
    DetectIngredientRequest(
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      utensils: (json['utensils'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DetectIngredientRequestToJson(
        DetectIngredientRequest instance) =>
    <String, dynamic>{
      'ingredients': instance.ingredients,
      'utensils': instance.utensils,
    };
