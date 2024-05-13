import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:snap_and_cook_mobile/data/remote/responses/base_response.dart';

import '../../../resources/services/recipe_service_constant.dart';
import '../models/utensil_model.dart';

part 'utensil_service.g.dart';

@RestApi()
abstract class UtensilServices {
  factory UtensilServices(Dio dio) = _UtensilServices;

  @GET(RecipeServiceConstants.utensils)
  Future<BaseResponse<List<Utensil>>> getAllUtensil(
      @CancelRequest() CancelToken cancelToken,
      );
}
