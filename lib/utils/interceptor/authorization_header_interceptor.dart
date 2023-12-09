import 'package:dio/dio.dart';

typedef TokenCallback = Future<String> Function();

class AuthorizationHeaderInterceptor extends Interceptor {
  TokenCallback onToken;

  AuthorizationHeaderInterceptor({required this.onToken});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String token = await onToken();
    bool authorization = true;
    if (options.headers.values.isNotEmpty) {
      options.headers.forEach((key, value) {
        if (key == "Authorization" && value == "disable") {
          authorization = false;
        }
      });
    }

    if (authorization) {
      if (options.headers.entries
          .where((element) => element.key == "Authorization")
          .isEmpty) {
        options.headers.addAll({
          'content-type': 'application/json',
          'Authorization': "Bearer $token"
        });
      }
    } else {
      options.headers.removeWhere(
          (key, value) => key == "Authorization" && value == "disable");
    }
    super.onRequest(options, handler);
  }
}
