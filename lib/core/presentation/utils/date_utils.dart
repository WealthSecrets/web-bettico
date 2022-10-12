import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();
  static String format(DateTime dateTime, {String? format}) {
    final DateFormat formatter = DateFormat(format ?? 'MMMM d, yyyy');
    return formatter.format(dateTime);
  }

  static int calculateDifference(DateTime date) {
    final DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
