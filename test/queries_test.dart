// import 'dart:developer';

import 'dart:developer';

import 'package:chores/database/queries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Can get kids from mongo", () async {
    var kids = await getKidsMongo(DateTime.now());
    assert(kids[0].kid.name == "Eliyahu");
    assert(kids[1].kid.name == "Yosef");
  });

  test("Get all chore days returns all chore days", () async {
    var choreDays = await getAllChoreDays();
    expect(
        choreDays[0].chores[0].chore, "Breakfast: clear dishes and utensils");
  });

  test("Get kids with choreDays", () async {
    var choreDays = await getKidsWithChoreDays();
    print(choreDays);
    expect(choreDays[0]['name'], "Eliyahu");
    expect(choreDays[0]['points'].runtimeType, int);
    expect(choreDays[1]['name'], "Yosef");
    expect(choreDays[1]['points'].runtimeType, int);
  });

  test("Get daily chores", () async {
    var dailyChores = await getDailyChores();
    for (var c in dailyChores) {
      log(c.toString());
    }
  });
}
