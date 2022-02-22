import 'package:chores/database/models/chore_constants.dart';

var choreStateMap = {
  ChoreState.unmarked: 0,
  ChoreState.done: 1,
  ChoreState.notDone: -1
};
var alternatingChoreStateMap = {
  ChoreState.unmarked: 0,
  ChoreState.notDone: 0,
  ChoreState.done: 3
};

class Chore {
  String chore;
  ChoreState done;
  Chore({
    required this.chore,
    required this.done,
  });

  factory Chore.fromMap(Map<String, dynamic> map) {
    return Chore(
        chore: map['chore'] ?? '',
        done: choreStateMap.keys
            .singleWhere((element) => element == map['done']));
  }

//  ChoreState getChoreState

  int getPoints() {
    return choreStateMap[done] ?? 0;
  }
}

class AlternatingChore extends Chore {
  AlternatingChore({required String chore, required ChoreState done})
      : super(chore: chore, done: done);

  @override
  int getPoints() {
    if (done == ChoreState.done) return 3;
    return 0;
  }
}
