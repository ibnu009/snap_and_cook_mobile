import 'package:snap_and_cook_mobile/data/remote/models/utensil_model.dart';

abstract class UtensilInterface {
  Future<List<Utensil>> fetchUtensils();

  Future<List<String>> fetchSelectedUtensils();

  Future<void> updateUtensil(Utensil utensil);
}
