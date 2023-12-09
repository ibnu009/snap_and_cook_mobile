import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:snap_and_cook_mobile/data/remote/models/recipe_model.dart';

abstract class RecipeInterface {
  Future<Either<DioError, List<Recipe>>> fetchRecipes(CancelToken cancelToken);
}
