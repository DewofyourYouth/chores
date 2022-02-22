import 'dart:convert';

import 'package:chores/database/models/chore_constants.dart';

class Chore {
  String chore;
  ChoreState done;
  bool isAlternating;

  Chore({
    required this.chore,
    required this.done,
    required this.isAlternating,
  });

  Chore copyWith({
    String? chore,
    ChoreState? done,
    bool? isAlternating,
  }) {
    return Chore(
      chore: chore ?? this.chore,
      done: done ?? this.done,
      isAlternating: isAlternating ?? this.isAlternating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chore': chore,
      'done': toMapHelper(done),
      'isAlternating': isAlternating,
    };
  }

  int calculatePoints() {
    var choreInt = toMapHelper(done);
    if (!isAlternating) {
      return choreInt;
    }
    return done != ChoreState.notDone ? choreInt * 3 : 0;
  }

  factory Chore.fromMap(Map<String, dynamic> map) {
    return Chore(
      chore: map['chore'] ?? '',
      done: fromMapHelper(map['done']),
      isAlternating: map['isAlternating'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chore.fromJson(String source) => Chore.fromMap(json.decode(source));

  @override
  String toString() => 'Chore(chore: $chore, done: $done)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chore && other.chore == chore && other.done == done;
  }

  @override
  int get hashCode => chore.hashCode ^ done.hashCode;
}

int toMapHelper(ChoreState cs) {
  switch (cs) {
    case ChoreState.unmarked:
      return 0;
    case ChoreState.done:
      return 1;
    case ChoreState.notDone:
      return -1;
  }
}

ChoreState fromMapHelper(int cs) {
  switch (cs) {
    case 0:
      return ChoreState.unmarked;
    case 1:
      return ChoreState.done;
    case -1:
      return ChoreState.notDone;
    default:
      return ChoreState.unmarked;
  }
}
