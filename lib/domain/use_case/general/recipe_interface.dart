import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../entities/recipe.dart';

abstract class RecipeInterface {
  Future<Either<DioError, List<Recipe>>> fetchRecipes(CancelToken cancelToken);

  Future<Either<DioError, Recipe>> fetchDetailRecipe(
      CancelToken cancelToken, String uuid);
}
