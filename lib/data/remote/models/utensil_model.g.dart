// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utensil_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Utensil _$UtensilFromJson(Map<String, dynamic> json) => Utensil(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isSelected: (json['isSelected'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UtensilToJson(Utensil instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };
