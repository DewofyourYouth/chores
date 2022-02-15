import 'package:chores/constants.dart';
import 'package:chores/database/models/chore.dart';
import 'package:chores/database/models/chore_day.dart';
import 'package:chores/utils/dates.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final eli = kids[0];
  final yosef = kids[1];
  final ay = kids[2];

  test("createDailyAlternating works", () {
    var d = DateTime(2022, 2, 15);
    var altMap = createDailyAlternating(d);
    expect(altMap[eli], "Clear couch +");
    expect(altMap[yosef], "Sweep and clear kitchen floor");
    expect(altMap[ay], "Clear table");
  });

  test("alternating chores alternate", () {
    var d = DateTime(2022, 2, 16);
    var altMap = createDailyAlternating(d);
    expect(altMap[eli], "Sweep and clear living room floor");
    expect(altMap[yosef], "Clear table");
    expect(altMap[ay], "Clear couch +");
    altMap = createDailyAlternating(d.addDays(1));
    expect(altMap[eli], "Clear table");
    expect(altMap[yosef], "Clear couch +");
    expect(altMap[ay], "Sweep and clear kitchen floor");
    altMap = createDailyAlternating(d.addDays(2));
    expect(altMap.isEmpty, true);
  });

  test("No alternating chores on Fridays or Saturdays", () {
    var friday = DateTime(2022, 2, 18);
    var saturday = DateTime(2022, 2, 19);
    var sunday = DateTime(2022, 2, 20);
    var altMap1 = createDailyAlternating(friday);
    var altMap2 = createDailyAlternating(saturday);
    var altMap3 = createDailyAlternating(sunday);
    expect(altMap1.isEmpty, true);
    expect(altMap2.isEmpty, true);
    expect(altMap3.isEmpty, false);
  });

  test("Alternating chores are fair", () {
    var n = DateTime.now();
    var date = DateTime(n.year, n.month, 1);
    var lastDayInMonth = findLastDayInMonth(n);
    var e = 0;
    var y = 0;
    var a = 0;
    for (int i = 0; i < lastDayInMonth; i++) {
      var d = date.addDays(i);
      var map = createDailyAlternating(d);
      if (map.isNotEmpty) {
        var key =
            map.keys.firstWhere((element) => map[element].startsWith("Sweep"));
        switch (key) {
          case "Eliyahu":
            e += 1;
            break;
          case "Yosef":
            y += 1;
            break;
          case "Asher Yitzchok":
            a += 1;
            break;
        }
      }
    }
    expect((a - e).abs() <= 2, true);
    expect((y - a).abs() <= 2, true);
    expect((e - y).abs() <= 2, true);
  });

  test("Can calculate daily score", () {
    var chores1 =
        ChoreDay(id: "bla", kidName: "Billy", date: DateTime.now(), chores: [
      Chore(chore: "Something else", done: false, isAlternating: false),
      Chore(chore: "Do somthing", done: true, isAlternating: true),
    ]);
    var chores2 =
        ChoreDay(id: "boop", kidName: "Sally", date: DateTime.now(), chores: [
      Chore(chore: "Do something", done: false, isAlternating: false),
      Chore(chore: "Do another thing", done: true, isAlternating: false),
      Chore(chore: "Do something else", done: true, isAlternating: true),
    ]);
    var chores3 =
        ChoreDay(id: "boop", kidName: "Timmy", date: DateTime.now(), chores: [
      Chore(chore: "Something else", done: true, isAlternating: false),
      Chore(chore: "Do something", done: false, isAlternating: true),
    ]);
    var chores4 =
        ChoreDay(id: "boop", kidName: "Sally", date: DateTime.now(), chores: [
      Chore(chore: "Do something", done: false, isAlternating: false),
      Chore(chore: "Do another thing", done: false, isAlternating: false),
      Chore(chore: "Do something else", done: false, isAlternating: true),
    ]);
    expect(chores1.calculateDailyScore(), 2);
    expect(chores2.calculateDailyScore(), 3);
    expect(chores3.calculateDailyScore(), 1);
    expect(chores4.calculateDailyScore(), -2);
  });
}
