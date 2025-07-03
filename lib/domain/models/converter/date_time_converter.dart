import 'package:json_annotation/json_annotation.dart';

import '../../../utils/extensions/date_ext.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateExt.parseUtc(json) ?? DateTime.now();
  }

  @override
  String toJson(DateTime object) {
    return object.toUtc().toString();
  }
}

class NullableDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const NullableDateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null) return null;
    return DateExt.parseUtc(json);
  }

  @override
  String? toJson(DateTime? object) {
    return object?.toUtc().toString();
  }
}
