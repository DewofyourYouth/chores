import 'package:chores/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("rotateList rotates a list of strings", () {
    const list = ['a', 'b', 'c'];
    expect(rotateList(list, 1), ['b', 'c', 'a']);
    expect(rotateList(list, 2), ['c', 'a', 'b']);
  });

  test("rotateList rotates a dynamic list", () {
    const list = [
      'a',
      5,
      [1, 2, "Phil"]
    ];
    expect(rotateList(list, 1), [
      5,
      [1, 2, "Phil"],
      'a'
    ]);
  });
}
