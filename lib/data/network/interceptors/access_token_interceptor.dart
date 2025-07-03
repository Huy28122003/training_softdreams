import 'package:dio/dio.dart';

import '../../local/preference/app_preferences.dart';

class AccessTokenInterceptor extends Interceptor {
  AccessTokenInterceptor(this._appPreferences);

  final AppPreferences _appPreferences;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _appPreferences.accessToken;

    if (token != null) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    return super.onRequest(options, handler);
  }
}
