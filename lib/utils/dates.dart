import 'package:intl/intl.dart';

DateTime getDay() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

var weekdayMonthDayYear = DateFormat("EEEE MM d, yyyy");
