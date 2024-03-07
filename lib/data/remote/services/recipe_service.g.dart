// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RecipeServices implements RecipeServices {
  _RecipeServices(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseResponse<List<RecipeModel>>> getAllRecipes(
    cancelToken,
    size,
    currentPage,
    search,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page[size]': size,
      r'page[current]': currentPage,
      r'filter[search]': search,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<List<RecipeModel>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'recipes',
              queryParameters: queryParameters,
              data: _data,
              cancelToken: cancelToken,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse<List<RecipeModel>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<RecipeModel>(
              (i) => RecipeModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<BaseResponse<RecipeModel>> getDetailRecipe(
    cancelToken,
    uuid,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<RecipeModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'recipe/${uuid}',
              queryParameters: queryParameters,
              data: _data,
              cancelToken: cancelToken,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse<RecipeModel>.fromJson(
      _result.data!,
      (json) => RecipeModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<List<RecipeModel>>> getRecipeRecommendation(
    cancelToken,
    request,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<List<RecipeModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'recipe/recommendation',
              queryParameters: queryParameters,
              data: _data,
              cancelToken: cancelToken,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse<List<RecipeModel>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<RecipeModel>(
              (i) => RecipeModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
