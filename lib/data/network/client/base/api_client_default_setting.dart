import 'dart:developer' as devtools show log;

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClientDefaultSetting {
  const ApiClientDefaultSetting._();

  static List<Interceptor> requiredInterceptors() => [
        PrettyDioLogger(
          logPrint: (object) => devtools.log(object.toString()),
        ),
      ];
}
