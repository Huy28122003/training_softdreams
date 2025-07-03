import 'package:dio/dio.dart';

abstract class BaseInterceptor extends InterceptorsWrapper {
  static const accessTokenPriority = 99;

  int get priority;
}
