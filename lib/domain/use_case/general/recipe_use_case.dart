import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/remote/models/recipe_model.dart';
import '../../../data/remote/services/recipe_service.dart';
import 'recipe_interface.dart';

class RecipeUseCase implements RecipeInterface {
  final service = Get.find<RecipeServices>();

  @override
  Future<Either<DioError, List<Recipe>>>
  fetchRecipes(CancelToken cancelToken) async {
    try {
      final response = await service.getAllRecipes(cancelToken);
      return Right(response.data ?? []);
    } on DioError catch (e) {
      return Left(e);
    }
  }
}
