import 'package:chores/constants.dart';
import 'package:intl/intl.dart';

DateTime getDay() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

final weekdayMonthDayYear = DateFormat("EEE MMM d, y");

extension DatePresets on DateTime {
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  bool alternatingDay() {
    return !daysOffAlternating.contains(DateFormat("EEEE").format(this));
  }
}
