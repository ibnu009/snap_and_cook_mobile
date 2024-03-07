
import 'package:json_annotation/json_annotation.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';

part 'detect_ingredient_request.g.dart';

@JsonSerializable()
class DetectIngredientRequest {
  List<Ingredient>? ingredients;
  List<String>? utensils;

  DetectIngredientRequest({
     this.ingredients,
     this.utensils,
  });

  Map<String, dynamic> toJson() => _$DetectIngredientRequestToJson(this);

  factory DetectIngredientRequest.fromJson(Map<String, dynamic> json) =>
      _$DetectIngredientRequestFromJson(json);
}
