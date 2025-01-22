import '../../../utils/date_format_utils.dart';

class DateRangeString {
  static String today() {
    return DateFormatUtils.formatDate(DateTime.now(),
        format: DateFormats.y_mo_d) as String;
  }

  static String last7days() {
    return DateFormatUtils.formatDate(
        DateTime.now().subtract(const Duration(days: 7)),
        format: DateFormats.y_mo_d) as String;
  }

  static String last30days() {
    return DateFormatUtils.formatDate(
        DateTime.now().subtract(const Duration(days: 30)),
        format: DateFormats.y_mo_d) as String;
  }
}
