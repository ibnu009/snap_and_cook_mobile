import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/data/remote/models/ingredient_model.dart';
import 'package:snap_and_cook_mobile/data/remote/requests/detect_ingredient_request.dart';

import '../../../data/remote/services/recipe_service.dart';
import '../../entities/recipe.dart';
import 'recipe_interface.dart';

class RecipeUseCase implements RecipeInterface {
  final service = Get.find<RecipeServices>();

  @override
  Future<Either<DioError, List<Recipe>>> fetchRecipes(
    CancelToken cancelToken, {
    required int size,
    required int currentPage,
    String? search,
  }) async {
    try {
      final response = await service.getAllRecipes(cancelToken, size, currentPage, search);
      List<Recipe> recipes = [];
      response.data?.forEach((element) {
        recipes.add(element.toEntity());
      });
      return Right(recipes);
    } on DioError catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<DioError, Recipe>> fetchDetailRecipe(
      CancelToken cancelToken, String uuid) async {
    try {
      final response = await service.getDetailRecipe(cancelToken, uuid);
      return Right(response.data?.toEntity() ?? Recipe());
    } on DioError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DioError(requestOptions: RequestOptions(path: "")));
    }
  }

  @override
  Future<Either<DioError, List<Recipe>>> fetchRecipeRecommendations(
      CancelToken cancelToken,
      List<Ingredient> ingredients,
      List<String> utensils) async {
    try {
      final response = await service.getRecipeRecommendation(
          cancelToken,
          DetectIngredientRequest(
              ingredients: ingredients, utensils: utensils));
      List<Recipe> recipes = [];
      response.data?.forEach((element) {
        recipes.add(element.toEntity());
      });
      return Right(recipes);
    } on DioError catch (e) {
      print("DioError is ${e}");
      return Left(e);
    } catch (e) {
      print("Error is ${e}");
      return Left(DioError(requestOptions: RequestOptions(path: "")));
    }
  }
}
