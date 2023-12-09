import 'package:dio/dio.dart';

extension DioExtention on Dio {
  Dio addInterceptor(Interceptor interceptor) {
    interceptors.add(interceptor);
    return this;
  }

  Dio baseUrl(String baseUrl) {
    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    );
    return this;
  }
   Dio modify(Function (Dio) modify) {
    modify.call(this);
    return this;
  }
}
