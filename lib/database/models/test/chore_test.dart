import 'package:chores/database/models/chores/daily_chore.dart';
import 'package:chores/database/models/chores/alternating_chore.dart';

import 'package:chores/database/models/chore_constants.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

main() {
  group("Daily Chore class", () {
    test('toMap works', () {
      var daily = DailyChore(chore: "Clean your room", done: ChoreState.done);
      expect(daily.toMap(), {'chore': "Clean your room", 'done': 'notDone'});
    });

    test("fromMap works", () {
      var choreMap1 = {"chore": "Chore 1", "done": "done"};
      var choreMap2 = {"chore": "Chore 2", "done": "unmarked"};
      var choreMap3 = {"chore": "Chore 3", "done": "notDone"};
      expect(
        DailyChore.fromMap(choreMap1),
        DailyChore(chore: "Chore 1", done: ChoreState.done),
      );
      expect(
        DailyChore.fromMap(choreMap2),
        DailyChore(chore: "Chore 2", done: ChoreState.unmarked),
      );
      expect(
        DailyChore.fromMap(choreMap3),
        DailyChore(chore: "Chore 3", done: ChoreState.notDone),
      );
    });

    test("getPoints works", () {
      var daily01 = DailyChore(chore: "Chore 1", done: ChoreState.done);
      var daily02 = DailyChore(chore: "Chore 2", done: ChoreState.notDone);
      var daily03 = DailyChore(chore: "Chore 3", done: ChoreState.unmarked);
      expect(daily01.getPoints(), 1);
      expect(daily02.getPoints(), -1);
      expect(daily03.getPoints(), 0);
    });
  });

  group("Alternating Chore class", () {
    test("toMap works", () {
      var alternating =
          AlternatingChore(chore: "Chore 1", done: ChoreState.done);
      expect(alternating.toMap(), {"chore": "Chore 1", "done": "done"});
    });
    test("fromMap works", () {
      var choreMap1 = {"chore": "Chore 1", "done": "done"};
      var choreMap2 = {"chore": "Chore 2", "done": "unmarked"};
      var choreMap3 = {"chore": "Chore 3", "done": "notDone"};
      expect(
        AlternatingChore.fromMap(choreMap1),
        AlternatingChore(chore: "Chore 1", done: ChoreState.done),
      );
      expect(
        AlternatingChore.fromMap(choreMap2),
        AlternatingChore(chore: "Chore 2", done: ChoreState.unmarked),
      );
      expect(
        AlternatingChore.fromMap(choreMap3),
        AlternatingChore(chore: "Chore 3", done: ChoreState.notDone),
      );
    });
    test("getPoints works", () {});
  });
}
