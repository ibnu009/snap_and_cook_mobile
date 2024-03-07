import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:snap_and_cook_mobile/data/remote/models/recipe_model.dart';
import 'package:snap_and_cook_mobile/data/remote/responses/base_response.dart';

import '../../../resources/services/recipe_service_constant.dart';
import '../requests/detect_ingredient_request.dart';

part 'recipe_service.g.dart';

@RestApi()
abstract class RecipeServices {
  factory RecipeServices(Dio dio) = _RecipeServices;

  @GET(RecipeServiceConstants.listRecipe)
  Future<BaseResponse<List<RecipeModel>>> getAllRecipes(
      @CancelRequest() CancelToken cancelToken,
      @Query("page[size]") int size,
      @Query("page[current]") int currentPage,
      @Query("filter[search]") String? search,
      );

  @GET(RecipeServiceConstants.detailRecipe)
  Future<BaseResponse<RecipeModel>> getDetailRecipe(
      @CancelRequest() CancelToken cancelToken, @Path("uuid") String uuid);

  @POST(RecipeServiceConstants.recipeRecommendation)
  Future<BaseResponse<List<RecipeModel>>> getRecipeRecommendation(
      @CancelRequest() CancelToken cancelToken,
      @Body() DetectIngredientRequest request);
}
