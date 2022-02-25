enum ChoreState {
  unmarked,
  done,
  notDone,
}

var mapDailyChoresToPoints = {
  ChoreState.unmarked: 0,
  ChoreState.done: 1,
  ChoreState.notDone: -1
};

var mapAlternatingChoresToPoints = {
  ChoreState.unmarked: 0,
  ChoreState.done: 3,
  ChoreState.notDone: 0,
};

extension GetNext on ChoreState {
  ChoreState next() {
    if (this == ChoreState.notDone) {
      return ChoreState.unmarked;
    }
    return ChoreState.values[index + 1];
  }
}
