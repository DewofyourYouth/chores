import 'package:chores/utils/dates.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test addDays extenstion", () {
    var date = DateTime(2022, 2, 13);
    expect(date.addDays(2), DateTime(2022, 2, 15));
    expect(date.addDays(-2), DateTime(2022, 2, 11));
  });

  test("Test weekdayMonthDayYear formatter", () {
    expect(
        weekdayMonthDayYear.format(DateTime(2022, 2, 15)), "Tue Feb 15, 2022");
  });

  test("Last day in January 2022 is 31", () {
    var date = DateTime(2022, 1, 12);
    expect(findLastDayInMonth(date), 31);
  });

  test("Last day in February 2022 is 28", () {
    var date = DateTime(2022, 2, 12);
    expect(findLastDayInMonth(date), 28);
  });
}
