import 'package:date_format/date_format.dart';

String choreFormatter(String chore) {
  return chore
      .split(" ")
      .map((s) => s.trim())
      .join("")
      .replaceAll(RegExp(r",|'|:"), "")
      .toLowerCase();
}

String dateFormatter(DateTime date) {
  return formatDate(date, [yyyy, "-", mm, "-", dd]);
}

DateTime getBeginningOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

String createChoreDayId(String kidName, DateTime date) {
  var fmtDate = dateFormatter(date);
  var kid = choreFormatter(kidName);
  return "$fmtDate:$kid";
}
