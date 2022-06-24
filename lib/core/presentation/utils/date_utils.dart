import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();
  static String format(DateTime dateTime, {String? format}) {
    final DateFormat formatter = DateFormat(format ?? 'MMMM d, yyyy');
    return formatter.format(dateTime);
  }
}
