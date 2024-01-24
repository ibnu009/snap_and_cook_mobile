import 'package:dio/dio.dart';

class PlatformHeaderInterceptor extends Interceptor {
  PlatformHeaderInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'content-type': 'application/json',
      'x-platform': 'apps',
      'Accept': 'application/json',
    });
    super.onRequest(options, handler);
  }
}
