import '../chore_constants.dart';
import 'chore.dart';
import 'daily_chore.dart';

class AlternatingChore extends DailyChore {
  AlternatingChore({required String chore, required ChoreState done})
      : super(chore: chore, done: done);
  static Map<ChoreState, int> choreStateToPoints = mapAlternatingChoresToPoints;

  @override
  Map<String, dynamic> toMap() {
    return {
      'chore': chore,
      'done': done.name,
      'isAlternating': isAlternating(),
    };
  }

  @override
  bool isAlternating() {
    return true;
  }

  @override
  int getPoints() {
    return choreStateToPoints[done] ?? 0;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlternatingChore &&
        other.chore == chore &&
        other.done == done;
  }

  @override
  String toString() {
    return "AlternatingChore(chore: $chore, done: $done)";
  }

  factory AlternatingChore.fromMap(Map<String, dynamic> map) {
    return AlternatingChore(
      chore: map['chore'] ?? '',
      done: ChoreState.values
          .firstWhere((element) => element.name == map['done']),
    );
  }
}

Chore chooseFromMap(Map<String, dynamic> m) {
  return m['isAlternating'] ?? false
      ? AlternatingChore.fromMap(m)
      : DailyChore.fromMap(m);
}
