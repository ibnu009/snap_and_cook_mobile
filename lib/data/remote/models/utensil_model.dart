import 'package:json_annotation/json_annotation.dart';

part 'utensil_model.g.dart';

@JsonSerializable()
class Utensil {
  int? id;
  String? name;
  int? isSelected;

  Utensil({
    this.id,
    this.name,
    this.isSelected,
  });

  Map<String, dynamic> toJson() => _$UtensilToJson(this);

  factory Utensil.fromJson(Map<String, dynamic> json) =>
      _$UtensilFromJson(json);
}