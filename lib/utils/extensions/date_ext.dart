import 'package:intl/intl.dart';

const String fullDateTimeFormat = 'dd-MM-yyyy, HH:mm';
const String utcDateFormat = 'yyyy-MM-dd';
const String utcDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
const String yMMMMdFormat = 'MMMM dd, yyyy';

extension DateExt on DateTime {
  static DateTime? parseUtc(String formattedString) {
    try {
      final dateTime =
          DateFormat(utcDateTimeFormat).parse(formattedString, true).toLocal();
      return dateTime;
    } catch (e) {
      return null;
    }
  }

  DateTime get date => DateTime(year, month, day);

  String formatDate([String format = fullDateTimeFormat]) {
    return DateFormat(format).format(this);
  }

  bool isToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(year, month, day);
    return dateToCheck == today;
  }
}
