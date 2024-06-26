import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:snap_and_cook_mobile/data/remote/responses/remote_detection_response.dart';

import '../../../data/remote/models/ingredient_model.dart';
import '../../entities/recipe.dart';

abstract class RecipeInterface {
  Future<Either<DioError, List<Recipe>>> fetchRecipes(CancelToken cancelToken, {
    required int size,
    required int currentPage,
    String? search,
  });

  Future<Either<DioError, List<Recipe>>> fetchRecipeRecommendations(
      CancelToken cancelToken,
      List<Ingredient> ingredients,
      List<String> utensils);

  Future<Either<DioError, Recipe>> fetchDetailRecipe(
      CancelToken cancelToken, String uuid);

  Future<Either<DioError, RemoteDetectionResponse>> detectIngredient(
      CancelToken cancelToken, File file);
}
