import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:snap_and_cook_mobile/data/remote/models/recipe_model.dart';
import 'package:snap_and_cook_mobile/data/remote/responses/base_response.dart';

import '../../../resources/services/recipe_service_constant.dart';

part 'recipe_service.g.dart';

@RestApi()
abstract class RecipeServices {
  factory RecipeServices(Dio dio) = _RecipeServices;

  @GET(RecipeServiceConstants.listRecipe)
  Future<BaseResponse<List<Recipe>>> getAllRecipes(
      @CancelRequest() CancelToken cancelToken);

  @GET(RecipeServiceConstants.detailRecipe)
  Future<BaseResponse<Recipe>> getDetailRecipe(
      @CancelRequest() CancelToken cancelToken, @Path("uuid") String uuid);
}
