import '../chore_constants.dart';
import 'chore.dart';

class DailyChore extends Chore {
  static Map<ChoreState, int> choreStateToPoints = mapDailyChoresToPoints;

  DailyChore({required String chore, required ChoreState done})
      : super(chore: chore, done: done);

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
    return false;
  }

  @override
  String toString() {
    return "DailyChore(chore: $chore, done: $done)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyChore && other.chore == chore && other.done == done;
  }

  factory DailyChore.fromMap(Map<String, dynamic> map) {
    return DailyChore(
        chore: map['chore'] ?? '',
        done: ChoreState.values
            .firstWhere((element) => element.name == map['done']));
  }

  @override
  int getPoints() {
    return choreStateToPoints[done] ?? 0;
  }
}
