import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  BaseResponse({
    required this.status,
    this.data,
    this.messages,
    this.errors,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$BaseResponseFromJson(json, fromJsonT);
  }

  final bool status;

  final T? data;

  final List<String>? messages;

  final List<String>? errors;

  @override
  String toString() => '''
  BaseResponse {
    status: $status,
    data: $data,
    messages: $messages,
    errors: $errors,
  }''';
}
