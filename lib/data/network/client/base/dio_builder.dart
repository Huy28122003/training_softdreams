import 'package:dio/dio.dart';

import '../../../../utils/constants/durations.dart';
import '../../../../utils/constants/url_constants.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    BaseOptions? options,
  }) {
    return Dio(
      BaseOptions(
        baseUrl: options?.baseUrl ?? UrlConstants.baseUrl,
        connectTimeout: options?.connectTimeout ?? defaultConnectionTimeout,
        receiveTimeout: options?.receiveTimeout ?? defaultReceiveTimeout,
        sendTimeout: options?.sendTimeout ?? defaultSendTimeout,
        contentType: options?.contentType ?? Headers.jsonContentType,
      ),
    );
  }
}
