// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      name: json['name'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'quantity': instance.quantity,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('unit', instance.unit);
  return val;
}
