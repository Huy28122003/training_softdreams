import 'package:dio/dio.dart';

import '../../../../utils/extensions/list_ext.dart';
import '../../interceptors/base_interceptor.dart';
import 'api_client_default_setting.dart';
import 'dio_builder.dart';

class RestClient {
  RestClient({
    this.baseUrl = '',
    this.interceptors = const [],
    Duration? receiveTimeout,
    Duration? connectTimeout,
    String? contentType,
  }) : _dio = DioBuilder.createDio(
          options: BaseOptions(
            baseUrl: baseUrl,
            contentType: contentType,
          ),
        ) {
    final sortedInterceptors = [
      ...ApiClientDefaultSetting.requiredInterceptors(),
      ...interceptors,
    ].sortedByDescending(
      (element) => element is BaseInterceptor ? element.priority : -1,
    );

    _dio.interceptors.addAll(sortedInterceptors);
  }

  final Dio _dio;
  final List<Interceptor> interceptors;
  final String baseUrl;

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path.startsWith(baseUrl) ? path.substring(baseUrl.length) : path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path.startsWith(baseUrl) ? path.substring(baseUrl.length) : path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path.startsWith(baseUrl) ? path.substring(baseUrl.length) : path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path.startsWith(baseUrl) ? path.substring(baseUrl.length) : path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> download(
    String path,
    String saveFilePath, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.download(
        path.startsWith(baseUrl) ? path.substring(baseUrl.length) : path,
        saveFilePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on Exception {
      rethrow;
    }
  }
}
