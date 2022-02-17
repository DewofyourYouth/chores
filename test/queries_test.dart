import 'package:chores/database/queries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Can get kids from mongo", () async {
    var kids = await getKidsMongo();
    assert(kids[0].name == "Eliyahu");
    assert(kids[1].name == "Yosef");
  });

  test("Get all chore days returns all chore days", () async {
    var choreDays = await getAllChoreDays();
    assert(choreDays[0].kidName == "Eliyahu");
    expect(
        choreDays[0].chores[0].chore, "Breakfast: clear dishes and utensils");
  });
}
