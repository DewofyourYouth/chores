import 'package:chores/database/models/chore_constants.dart';
import 'package:flutter/material.dart';

class DoneIndicator extends StatelessWidget {
  final ChoreState done;
  const DoneIndicator({Key? key, required this.done}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (done) {
      case ChoreState.unmarked:
        return const Icon(Icons.sentiment_neutral);
      case ChoreState.done:
        return const Icon(
          Icons.mood,
          color: Colors.tealAccent,
        );
      case ChoreState.notDone:
        return const Icon(
          Icons.mood_bad,
          color: Colors.orangeAccent,
        );
    }
  }
}
