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

  bool isAlternatingDay() {
    const daysOffAlternating = [
      DateTime.friday,
    ];
    return !daysOffAlternating.contains(weekday);
  }
}

int findLastDayInMonth(DateTime date) {
  var isDecember = date.month == DateTime.december;
  return DateTime(!isDecember ? date.year : date.year + 1,
          !isDecember ? date.month + 1 : 1, 1)
      .subtract(const Duration(days: 1))
      .day;
}
