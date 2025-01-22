import 'package:intl/intl.dart';

class DateFormats {
  static const String full = 'yyyy-MM-dd HH:mm:ss';

  static const String y_mo_d = 'yyyy-MM-dd';

  static const String y_mo_d_h_m = 'yyyy-MM-dd HH:mm';

  static const String y_mo = 'yyyy-MM';
  static const String mo_d = 'MM-dd';
  static const String mo_d_h_m = 'MM-dd HH:mm';
  static const String h_m_s = 'HH:mm:ss';
  static const String h_m = 'HH:mm';
}

abstract class DateFormatUtils {
  static String? formatDate(DateTime? dateTime, {String? format}) =>
      dateTime == null
          ? null
          : DateFormat(format ?? DateFormats.full).format(dateTime);

  static DateTime? from(String? dateStr, {String? format}) => dateStr == null
      ? null
      : DateFormat(format ?? DateFormats.full).parse(dateStr);
}
