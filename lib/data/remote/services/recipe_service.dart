import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:snap_and_cook_mobile/data/remote/models/recipe_model.dart';
import 'package:snap_and_cook_mobile/data/remote/responses/base_response.dart';
import 'package:snap_and_cook_mobile/data/remote/responses/remote_detection_response.dart';

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


  @MultiPart()
  @POST(RecipeServiceConstants.detection)
  @Headers(<String, dynamic>{'x-api-key': '60020bbdfe8f3fb3a78ca3ddfb1c429e7f34697b97'})
  Future<RemoteDetectionResponse> detectIngredient(
      @CancelRequest() CancelToken cancelToken,
      @Path('key') String key,
      @Part(name: 'size') String? size,
      @Part(name: 'confidence') String? confidence,
      @Part(name: 'iou') String? iou,
      @Part(name: 'image') File file,
      );
}
