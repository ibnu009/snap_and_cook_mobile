import 'package:intl/intl.dart';

class JsonSerializableUtil {
  static DateTime? fromJsonYyyyMmDdTHhMmSsZ(String? date) {
    if (date != null && date.isNotEmpty) {
      try {
        return DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(date);
      } catch (e) {
        try {
          return DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }

  static String? toJsonYyyyMmDdTHhMmSsZ(DateTime? date) {
    if (date != null) {
      try {
        return DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(date);
      } catch (e) {
        try {
          return DateFormat("yyyy-MM-dd HH:mm:ss").format(date);
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }
}

class DateTimeWithBool {
  final DateTime date;
  bool isScheduleYyyMmDdHhMmSs;

  DateTimeWithBool({required this.date, this.isScheduleYyyMmDdHhMmSs = true});
}
