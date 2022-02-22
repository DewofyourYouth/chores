enum ChoreState {
  unmarked,
  done,
  notDone,
}

extension GetNext on ChoreState {
  ChoreState next() {
    if (this == ChoreState.notDone) {
      return ChoreState.unmarked;
    }
    return ChoreState.values[index + 1];
  }
}
