import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../interceptor/pretty_dio_logger_interceptor.dart';

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

  Dio usePrettyLogger() {
    addInterceptor(PrettyDioLoggerInterceptor());
    return this;
  }

  Dio useChucker() {
    addInterceptor(ChuckerDioInterceptor());
    return this;
  }
}
